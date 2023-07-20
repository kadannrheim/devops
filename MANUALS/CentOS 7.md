Настройка сети
```
ifconfig -a
vim /etc/sysconfig/network-scripts/ifcfg-eth1
BOOTPROTO=none
DEFROUTE=yes
DEVICE=eth1
HWADDR=00:15:5d:01:7a:12
IPADDR=172.30.17.22
MTU=1500
NETMASK=255.255.255.0
ONBOOT=yes
STARTMODE=auto
TYPE=Ethernet
```