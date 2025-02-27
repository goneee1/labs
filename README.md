# Практическое задание 1
## Описание: 
 1
Развертывание `Minikube`. Работа с манифестами

## Этапы выполнения 

1. Произведите развертывание системы `minikube` на рабочем компьютере или виртуальной машине.

![image](https://github.com/user-attachments/assets/37c9cb1d-b167-4c2d-98e8-c0b9d6af50b7)



1. Cоздайте файл `pod.yaml` и скопируйте в него следующий манифест:.
![image](https://github.com/user-attachments/assets/2a93900c-1237-44c7-a893-ff1bcb1537a1)


Тело ошибки связанное с синтаксисом нет отступа в виде `-`:

```bash
(kali㉿kali)-[~]
└─$ kubectl create -f pod.yaml              
Error from server (BadRequest): error when creating "pod.yaml": Pod in version "v1" cannot be handled as a Pod: json: cannot unmarshal object into Go struct field PodSpec.spec.containers of type []v1.Container
```

1.  Запустите pod redis в кластере с помощью команды: `kubectl run redis -- image=redis:5.0 -n default`
![image](https://github.com/user-attachments/assets/efb106fb-326a-4c00-8a6f-5eb4ccb9704e)


Логи скрин
![image](https://github.com/user-attachments/assets/bce7b56d-e083-482e-9317-44d4c66f2853)


# Практическое задание 2
## Описание: 
Развертывание инфраструктуры c помощью Terraform.
**Все файлы и конфиги прикреплены в репозитории, если хотите получить доступ к машинам для проверки отправьте публичный ssh ключ на корпоративную почту или в тг @ggmozz **
<img width="846" alt="ssh_connect" src="https://github.com/user-attachments/assets/e42f10cc-4eff-4752-bd1c-8c78fd3e33cb" />
<img width="919" alt="terraform" src="https://github.com/user-attachments/assets/5cb10750-8f7b-467d-8907-76529c383633" />

