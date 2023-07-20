# Настройка windows
https://evgeniyprokopev.com/vagrant-samyj-prostoj-i-bystryj-sposob-sozdaniya-izolirovannoj-sredy-razrabotki/
1. Скачать Vagrant
2. Добавить в path


----
config.vm.box — базовый образ. В нашем случае Ubuntu 22.04
config.vm.provider — система виртуализации. Доступные провайдеры: VirtualBox, VMware, Hyper-V, Docker и др.
config.vm.hostname — имя хоста.
config.vm.synced_folder — синхронизация папок. Первым параметром передается путь хостовой (основной) машины, вторым параметром передается путь гостевой (виртуальной машины)
config.vm.network — настройки сети. Мы настроили перенаправление портов и статический ip-адрес, к которому привяжем домен newapp.loc. Доступны и другие настройки.
config.vm.provision — служит для автоматической установки и настройки программного обеспечения. Мы использовали самый простой способ Shell-скрипт, также доступны другие: Ansible, Chef, Puppet и др.

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-22.04"
  # имя пользователя
  config.ssh.username = 'vagrant'
  # пароль пользователя
  config.ssh.password = 'vagrant'
  config.ssh.insert_key = false

  config.vm.provider "virtualbox" do |vb|
    vb.name = "usk8s1"
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.hostname = "usk8s1vg"

  config.vm.synced_folder ".", "C:\Users\kadannr\Documents\vagrant",
    owner: "www-data", group: "www-data"
  
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 3306, host: 33060

  config.vm.network "private_network", ip: "192.168.88.188"

  config.vm.provision "shell", path: "provision.sh"
end
```
Для удобства настройка системы вынесена в отдельный файл `provision.sh`. Во время установки Vagrant запустит его внутри созданной виртуальной машины. К примеру  Необходима среда разработки, в которой, к примеру установлена операционная система Linux со специфичными настройками, зависимости проекта и необходимые программы (MySQL, Nginx, PHP и т.д.). Содержимое файла `provision.sh`:
```bash
apt-get update
apt-get -y upgrade

apt-add-repository ppa:ondrej/php -y

apt-get update

apt-get install -y software-properties-common curl zip

apt-get install -y php7.2-cli php7.2-fpm \
php7.2-pgsql php7.2-sqlite3 php7.2-gd \
php7.2-curl php7.2-memcached \
php7.2-imap php7.2-mysql php7.2-mbstring \
php7.2-xml php7.2-json php7.2-zip php7.2-bcmath php7.2-soap \
php7.2-intl php7.2-readline php7.2-ldap

apt-get install -y nginx

rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default

cat > /etc/nginx/sites-available/newapp <<EOF
server {
    listen 80;
    server_name .newapp.loc;
    root "/home/vagrant/code";

    index index.html index.htm index.php;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/newapp-error.log error;

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}
EOF

ln -s /etc/nginx/sites-available/newapp /etc/nginx/sites-enabled/newapp

service nginx restart
```


# Вагран файл от нетологии
https://github.com/netology-code/virt-homeworks/blob/virt-11/05-virt-02-iaac/src/vagrant/ansible.cfg
```ruby
# -*- mode: ruby -*-

ISO = "bento/ubuntu-20.04"
NET = "192.168.56."
DOMAIN = ".netology"
HOST_PREFIX = "server"
INVENTORY_PATH = "../ansible/inventory"

servers = [
  {
    :hostname => HOST_PREFIX + "1" + DOMAIN,
    :ip => NET + "11",
    :ssh_host => "20011",
    :ssh_vm => "22",
    :ram => 1024,
    :core => 1
  }
]

Vagrant.configure(2) do |config|
  config.vm.synced_folder ".", "/vagrant", disabled: false
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = ISO
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]
      node.vm.network :forwarded_port, guest: machine[:ssh_vm], host: machine[:ssh_host]
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
        vb.customize ["modifyvm", :id, "--cpus", machine[:core]]
        vb.name = machine[:hostname]
      end
      node.vm.provision "ansible" do |setup|
        setup.inventory_path = INVENTORY_PATH
        setup.playbook = "../ansible/provision.yml"
        setup.become = true
        setup.extra_vars = { ansible_user: 'vagrant' }
      end
    end
  end
end
```