#!/bin/bash

#COLOR

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'



Help(){
 echo -e "\n
Использование: task-reloader-kapasitor.sh [КЛЮЧ]… [КЛЮЧ]…\n
Скрипт удаляет топики капаситора и ребутает соответствующие таски\n"
 echo -e "-h, --help\t Показать эту справку и выйти"
 echo -e "-n (namespace)\t Выполняет скрипт для всего пространства, допустим 'spbparking'. Рекомендуется использовать с ключом '-s'"
 echo -e "-s (service)\t Выбор необходимого инстанса в указанном пространстве, допустим 'mongo'"
 echo -e "\n
Примеры:\n"
 echo "/.task-reloader-kapasitor.sh -n spbparking"
 echo -e "/.task-reloader-kapasitor.sh -n spbparking -s mongo\n"
}


#CASE FOR SCRIPT

while getopts ":h :n:s:" flag
do
    case "${flag}" in 
    	h | --help) Help
	exit;;
    	n) namespace=${OPTARG};;
    	s) service=${OPTARG};;
    esac
done


#PREFLYING CHECKS
if [ -n "$service" ]; then
		kapacitor list topics | grep $namespace | grep $service | awk '{print $1}' > relfile.txt
	else
		kapacitor list topics | grep $namespace | awk '{print $1}' > relfile.txt
fi		

if [ -s relfile.txt ]; then
		echo -e "\nНайдены совпадения\n"
	else
		echo -e "\nНичего не найдено\n"
		exit;
fi


for TOPIC in $(cat relfile.txt); do
	TASK=$(echo $TOPIC | awk -F ':' '{print $2}')
	echo -e "Topic : (${RED}$TOPIC${NC}) ---> Тask : (${RED}$TASK${NC})"
done

echo -e "\n
Данные топики будут удалены, а таски перезагружены. Даёте согласие?"

while :; do 
	read -p "Yes/no: " yn
	case $yn in
  	  yes ) echo -e "\n
Вы подтвердили согласие, начинаю работу...\n";;
  	  no ) echo -e "\n
Закрытие...";
   	    exit;;
  	  * ) echo -e "\n
Вы указали недопустимые значения (Error:$?, ProssesID:$$)";
    	   continue;;
	esac
	break
done


#RUNNER

for TOPIC in $(cat relfile.txt); do
        TASK=$(echo $TOPIC | awk -F ':' '{print $2}')
        kapacitor delete topics $TOPIC
	echo -e "Топик (${RED}$TOPIC${NC}) ${GREEN}удален${NC}"
	kapacitor reload tasks $TASK
	echo -e "Таск (${RED}$TASK${NC}) ${GREEN}перезапущен${NC}"
	echo -e "\n
\t ${RED}Powred by ${GREEN}©РАДЖЕШteam\n"

done

