# Практическое задание 1
## Описание: 
Развертывание `Minikube`. Работа с манифестами

## Этапы выполнения 

1. Произведите развертывание системы `minikube` на рабочем компьютере или виртуальной машине.

![image](https://github.com/user-attachments/assets/37c9cb1d-b167-4c2d-98e8-c0b9d6af50b7)



2. Cоздайте файл `pod.yaml` и скопируйте в него следующий манифест:.

![image](https://github.com/user-attachments/assets/2a93900c-1237-44c7-a893-ff1bcb1537a1)


Тело ошибки связанное с синтаксисом нет отступа в виде `-`:

```bash
(kali㉿kali)-[~]
└─$ kubectl create -f pod.yaml              
Error from server (BadRequest): error when creating "pod.yaml": Pod in version "v1" cannot be handled as a Pod: json: cannot unmarshal object into Go struct field PodSpec.spec.containers of type []v1.Container
```

3.  Запустите pod redis в кластере с помощью команды: 
`kubectl run redis -- image=redis:5.0 -n default`
   
![image](https://github.com/user-attachments/assets/efb106fb-326a-4c00-8a6f-5eb4ccb9704e)


Логи скрин

![image](https://github.com/user-attachments/assets/bce7b56d-e083-482e-9317-44d4c66f2853)


# Практическое задание 2
## Описание: 
Развертывание инфраструктуры c помощью Terraform.
**Все файлы и конфиги прикреплены в репозитории, если хотите получить доступ к машинам для проверки запросите пароль от архива на корпоративную почту или в тг `@ggmozz` ** публчиный ip машины `84.201.132.135` `user:centos`
<img width="846" alt="ssh_connect" src="https://github.com/user-attachments/assets/e42f10cc-4eff-4752-bd1c-8c78fd3e33cb" />
<img width="919" alt="terraform" src="https://github.com/user-attachments/assets/5cb10750-8f7b-467d-8907-76529c383633" />

# Практическое задание 3 
## Описание:
Работа с системой Docker
Докерфайл прикреплён в репозитории лабы
Скрин с работой докера и его доступностью
![image](https://github.com/user-attachments/assets/db4130f7-eb1c-442e-aac6-bcadde8bb056)

## Настройка:
1. Создать dockerfile с содердимым конфига.
   Содержимое:
```
FROM ubuntu:latest

RUN apt update && apt install -y wget curl nginx

COPY index.html /var/www/html/index.html

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
```
2. Билдим докер образ
`sudo docker buid -t dockerfile .`
3. Проверяем что на наших портах 80 и 443 не запущены другие сервисы
`sudo lsof -i :80,443`
4. Запускаем наш docker контейнер:
`sudo docker run -d -p 80:80 -p 443:443 dockerfile:latest`
5. Проверяем работоспособность докера
`sudo docker ps -a`
### 2 часть создание субд в докере 
1. Команда для создания БД sql:
```mysql
-- testdb.sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

INSERT INTO users (name, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com');
```
2. Запускаем докер postgres на базовом порту с установкой пароля и пользователя 
```  
 sudo docker run -d \
  --name postgres_db \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_DB=testdb \
  -p 5432:5432 \
  postgres:latest
```
3. Выполнение sql команд в бд testdb 
`sudo cat test.sql | sudo docker exec -i postgres_db psql -U admin -d testdb`

4. Подключние к бд
`docker exec -it postgres_db psql -U admin -d testdb`

5. Проверка
![image](https://github.com/user-attachments/assets/0536ad64-019d-4524-89d5-3390e0001266)








