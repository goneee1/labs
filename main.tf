terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.90"
    }
  }
}

provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

# Сеть
resource "yandex_vpc_network" "network" {
  name = "ithub_network"
}

# Подсеть
resource "yandex_vpc_subnet" "subnet" {
  name           = "ITHUBterraformsubnet-mozer"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.250.0/24"]  # CIDR блок подсети
}

# Группа безопасности
resource "yandex_vpc_security_group" "firewall" {
  name       = "ithub_firewall"
  network_id = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP"
    port          = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTPS"
    port          = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH"
    port          = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "UDP"
    description    = "Allow DNS"
    port          = 53
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Cloud-init для установки ПО
data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content = <<EOF
#cloud-config
package_update: true
packages:
  - curl
  - wget
  - nginx
runcmd:
  - systemctl enable nginx
  - systemctl start nginx
EOF
  }
}

# Виртуальные машины
resource "yandex_compute_instance" "vm" {
  count = 3
  name  = "ithub_terraforubuntuper${count.index + 1}_mozer"
  zone  = "ru-central1-a"  # Все машины в одной зоне

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd85qh2iveusn11jcup6"  # Замените на актуальный ID образа
    }
  }

  network_interface {
    subnet_id     = yandex_vpc_subnet.subnet.id
    nat           = true
    security_group_ids = [yandex_vpc_security_group.firewall.id]  # Используем правильный параметр
  }

  metadata = {
    ssh-keys  = "centos:${file("~/.ssh/id_rsa.pub")}"
    user-data = data.template_cloudinit_config.config.rendered
  }
}

# Вывод данных
output "vm_info" {
  value = [
    for instance in yandex_compute_instance.vm : instance.name
  ]
}
