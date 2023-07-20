#!/bin/bash

read -p "Введите дату в формате YYYY-MM-DD: " date

logfile="/backup/s3_logs/data/logs/$date/common-sms-sender-emp-$date.log.gz"
resultfile="result.txt"

touch "$resultfile"

if [ -f "$logfile" ]; then
    zcat "$logfile" | while read -r line; do
        destination=$(echo "$line" | grep -o 'destination\":\"[^\"]*' | sed 's/destination\":\"//')
        ext_message_id=$(echo "$line" | grep -o 'extMessageId=[^ ]*' | cut -d'=' -f2)
        if [[ ! -z $destination && ! -z $ext_message_id ]]; then
            echo "${destination//\"} - ${ext_message_id}" >> "$resultfile"
        fi
    done
    echo "Результат сохранен в файл $resultfile."
else
    echo "Файл $logfile не найден."
fi
