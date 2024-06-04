## Подготовка
Склонируйте репозиторий с файлами на свою виртуальную машины в YC.
```
git clone https://github.com/The-Elegance/YC-Packer-Terraform
```

## Установка YC CLI
```
bash yc_install.bash
```

## Установка Packer

```
bash packer_install.bash
exec -l $SHELL
yc init
```

## Сборка образа ubuntu с terraform

> [!IMPORTANT]  
> Перед использование packer build terraform.pkr.hcl, подставьте данные ваши из Yandex Cloud.
> Переменная токен может содержать как OAuth Token, так и IAM Token
> Для редактирования данных используйте nano terraform.pkr.hcl

_Требуемые данные можно получить используя YC CLI_
```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

echo $YC_TOKEN
echo $YC_CLOUD_ID
echo $YC_FOLDER_ID
```

**Команда для сборки образа на YC**
```
packer build terraform.pkr.hcl
```
