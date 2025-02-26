## Описание: 
Лаба 1
Развертывание `Minikube`. Работа с манифестами

## Этапы выполнения 

1. Произведите развертывание системы `minikube` на рабочем компьютере или виртуальной машине.

![[Pasted image 20250226182413.png]]


1. Cоздайте файл `pod.yaml` и скопируйте в него следующий манифест:. ![[Pasted image 20250226182534.png]]

Тело ошибки связанное с синтаксисом нет отступа в виде `-`:

```bash
(kali㉿kali)-[~]
└─$ kubectl create -f pod.yaml              
Error from server (BadRequest): error when creating "pod.yaml": Pod in version "v1" cannot be handled as a Pod: json: cannot unmarshal object into Go struct field PodSpec.spec.containers of type []v1.Container
```

1.  Запустите pod redis в кластере с помощью команды: `kubectl run redis -- image=redis:5.0 -n default`
![[Pasted image 20250226182854.png]]

Логи
![[Pasted image 20250226183048.png]]
