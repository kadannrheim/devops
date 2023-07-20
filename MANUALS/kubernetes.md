# Настройка трёхноводого кластера.
Всего 4 машины, 3 ноды и 1 балансировщик haproxy

	sudo yum install net-tools
смотрим мак и подставляем его в ifcfg-eth1
	ifconfig
```
vim  /etc/sysconfig/network-scripts/ifcfg-eth1
BOOTPROTO=none
DEFROUTE=yes
DEVICE=eth1
HWADDR=00:15:5d:01:7a:16
IPADDR=172.30.17.17
MTU=1500
NETMASK=255.255.255.0
ONBOOT=yes
STARTMODE=auto
TYPE=Ethernet
```
Перезагружаем сеть
	systemctl restart network
Проверяем что получилось. 192.168.1.115 статика в микроте (wan), 172.30.17.17 статика на хосте (default switch)
```
ip -4 a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    inet 192.168.1.115/24 brd 192.168.1.255 scope global noprefixroute dynamic eth0
       valid_lft 259190sec preferred_lft 259190sec
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    inet 172.30.17.17/24 brd 172.30.17.255 scope global noprefixroute eth1
       valid_lft forever preferred_lft forever
```
Доустанавливаем в ОС для управление iptables 
	yum -y install iptables-services
Вместо modprobe br_netfilter
	modprobe ip_conntrack

Вместо sysctl -w net.netfilter.nf_conntrack_max=1048576
	echo "net.netfilter.nf_conntrack_max=1048576" >> /etc/sysctl.conf