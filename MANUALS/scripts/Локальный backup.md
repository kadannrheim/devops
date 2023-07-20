https://g-soft.info/articles/8992/bash-skript-rezervnogo-kopirovaniya-direktoriy-sistemy-linux/
```
```bash
#!/bin/bash
####################################
# Резервное копирование в NFS.
####################################

# Что нужно копировать.
backup_files="/home /var/spool/mail /etc /root /boot /opt"

# Куда создать резервную копию.
dest="/mnt/backup"

# Создание имя файла архива.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Выведите сообщение о состоянии запуска.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Резервное копирование файлов с помощью tar.
tar czf $dest/$archive_file $backup_files

# Выведите сообщение о завершении работы.
echo
echo "Backup finished"
date

# Длинный список файлов в $dest для проверки размеров файлов.
ls -lh $dest
```
```



#!/bin/bash
# whats copy
way="/home/kadannr/"

# where copy
backup_folder="/var/tmp/backup/"

# name backup
day=$(date +%A")
hostname=$(hostname -s)
arhive_files=$($hostname-$day.tgz)

# echo info in progress
echo "Starting backup $way to $backup_folder/arhive_file"

# tar backup
tar czf $backup_folder/$arhive_files $way

# echo info
echo "Backup finished"

# ls backuping files
ls -lh $backup_folder