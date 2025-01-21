# Лукция OTUS. Bash Написание простых скриптов

 

----
# Создание пользователя и добавление в группу sudo
sudo useradd -m -s /bin/bash -c "Kadannr User" kadannr
sudo passwd kadannr
	miceliy@321
sudo usermod -aG sudo kadannr
su - kadannr
sudo mkdir -p /srv/apps/sysmon -проверяем создавая папку где имеет доступ только sudo

----
# Двойная строки и ее подсветка bash
* `sudo vim ~/.bashrc` -редактируем файл
Добавляем в него в самый конец:
```
INPUT_COLOR="\[\033[0m\]"
DIR_COLOR="\[\e[32m]"
DIR="\w"

LINE_VERTICAL="\342\224\200"
LINE_CORNER_1="\342\224\214"
LINE_CORNER_2="\342\224\224"
LINE_COLOR="\[\033[0;37m\]"

USER_NAME="\[\033[0;32m\]\u"
# или \033[101m
SYMBOL="\[\033[0;32m\]$"

if [[ ${EUID} == 0 ]]; then
    USER_NAME="\[\033[0;31m\]\u"
    SYMBOL="\[\033[0;31m\]#"
fi

# двойная строка приглашения с временем
PS1="$LINE_COLOR$LINE_CORNER_1$LINE_VERTICAL \h & $USER_NAME $DIR_COLOR$DIR \t \n$LINE_COLOR$LINE_CORNER_2$LINE_VERTICAL $SYMBOL $INPUT_COLOR"

# отображение даты и времени в history
export HISTTIMEFORMAT='%F %T '

```
# Ссылка для донастройки другой подсветки
[ССЫЛКА](https://ziggi.org/cveta-v-terminale/)


