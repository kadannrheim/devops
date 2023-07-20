# На примере FTP
Установил iptables-service на msk-pp-vpn, внес все текущие записи, добавил новые пробросы:

```
$ sudo cat /etc/sysconfig/iptables
...
-A PREROUTING -d 172.22.202.205/32 -p tcp -m tcp --dport 20 -j DNAT --to-destination 192.168.7.30:20
-A PREROUTING -d 172.22.202.205/32 -p tcp -m tcp --dport 21021 -j DNAT --to-destination 192.168.7.30:21021
-A PREROUTING -d 172.22.202.205/32 -p tcp -m tcp --dport 30000:30020 -j DNAT --to-destination 192.168.7.30:30000-30020
...
```
Проверил работу:
```
[Пыльнов Андрей](https://jira.fabit.ru/secure/ViewProfile.jspa?name=pylnov)  
Адрес для подключения: 172.22.202.205  
Порт: 21021
```

```
$ ftp 172.22.202.205 21021
Connected to 172.22.202.205.
220 FTP Server ready.
Name (172.22.202.205:malykhin): qaman
331 Password required for qaman
Password:
230 User qaman logged in.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> passiv
Passive mode on.
ftp> ls
227 Entering Passive Mode (172,22,202,205,117,60).
150 Opening ASCII mode data connection for file list
drwxr-xr-x   4 qaman    1004           88 Mar  1  2022 .
drwxr-xr-x   4 qaman    1004           88 Mar  1  2022 ..
drwxrwxrwx   2 qaman    1004           90 Nov 30  2021 grants_integration_import_catalog
drwxrwxrwx   2 qaman    1004         4096 Dec 30  2021 importCatalog
-rw-r--r--   1 qaman    1004         1120 Mar  1  2022 response.xml
226 Transfer complete
```
