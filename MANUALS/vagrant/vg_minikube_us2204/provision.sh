# Update apt and get dependencies
sudo apt-get -y upgrade
sudo apt-get install -y vim mc atop htop tmux screen
touch /home/vagrant/tools.md
touch /home/vagrant/setup.log
echo '---------------kubectl-----------------'
# Установка kubectl https://kubernetes.io/ru/docs/tasks/tools/install-kubectl/#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-kubectl-%D0%B2-linux
# Загрузите последнюю версию с помощью команды:
curl -LO https://dl.k8s.io/release/`curl -LS https://dl.k8s.io/release/stable.txt`/bin/linux/amd64/kubectl
# Сделайте бинарный файл kubectl исполняемым:
chmod +x ./kubectl
# Переместите бинарный файл в директорию из переменной окружения PATH:
sudo mv ./kubectl /usr/local/bin/kubectl
# Убедитесь, что установлена последняя версия:

echo '---------------kubectl-----------------' >> /home/vagrant/setup.log
kubectl version --client >> setup.log
echo '---------------kubectl-----------------' >> /home/vagrant/setup.log


echo '---------------docker-----------------'
# Установка docker https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
# 1. Первым делом обновите существующий список пакетов:
sudo apt update
#Затем установите несколько необходимых пакетов, которые позволяют apt использовать пакеты через HTTPS:
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
#Добавьте ключ GPG для официального репозитория Docker в вашу систему:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#Добавьте репозиторий Docker в источники APT:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
#Потом обновите базу данных пакетов и добавьте в нее пакеты Docker из недавно добавленного репозитория:
sudo apt update
#Убедитесь, что установка будет выполняться из репозитория Docker, а не из репозитория Ubuntu по умолчанию:
echo '---------------docker-----------------' >> /home/vagrant/inshare/setup.log
apt-cache policy docker-ce >> /home/vagrant/setup.log
echo '---------------docker-----------------' >> /home/vagrant/inshare/setup.log
# 2. Установите Docker:
sudo apt install -y docker-ce
#Docker должен быть установлен, демон-процесс запущен, а для процесса активирован запуск при загрузке. Проверьте, что он запущен:
sudo systemctl status docker >> /home/vagrant/setup.log

# 3. Если вы не хотите каждый раз вводить sudo при запуске команды docker, добавьте свое имя пользователя в группу docker:
sudo usermod -aG docker vagrant
#Чтобы применить добавление нового члена группы, выйдите и войдите на сервер или введите следующее:
su - vagrant
echo '---------------docker-----------------' >> /home/vagrant/setup.log

echo '---------------minikube-----------------' 
# Устновка minikube https://kubernetes.io/ru/docs/tasks/tools/install-minikube/
# ОБЯЗАТЕЛЬНО ДОЛЖНА БЫТЬ ВКЛЮЧЕНА ВИРТУАЛИЗАЦИЯ, ИНСТРУКЦИЯ В minikube.md
# Установка Minikube с помощью прямой ссылки
# Загрузить двоичный файл и использовать его вместо установки пакета:
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
&& chmod +x minikube
# Чтобы исполняемый файл Minikube был доступен из любой директории выполните следующие команды:
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/
# Стартуем minikube
minikube start --driver=docker

# Вручную после установки
# 3. Если вы не хотите каждый раз вводить sudo при запуске команды docker, добавьте свое имя пользователя в группу docker:
# echo 'docker без sudo:' >> /home/vagrant/tools.md
echo 'sudo usermod -aG docker ${USER}' >> /home/vagrant/tools.md
#Чтобы применить добавление нового члена группы, выйдите и войдите на сервер или введите следующее:
echo 'su - ${USER}' >> /home/vagrant/tools.md
echo 'запуск minikube на docker:' >> /home/vagrant/tools.md
echo ''''minikube start --driver=docker'''' >> /home/vagrant/tools.md