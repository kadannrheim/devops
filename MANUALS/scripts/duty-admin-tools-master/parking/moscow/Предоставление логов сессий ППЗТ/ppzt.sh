#!/bin/bash

echo '' > datesPPZT.txt
rm /home/stepanenko/PPZT/ppzt-logs.tar #укажите свои директории
rm -rf /home/stepanenko/PPZT/logs/* #укажите свои директории
var=operation=parking

cat param.txt | awk '{print $2}' | sed -e 's/\./\-/g' param.txt | awk '{print$2}' | perl -lne 'print join "-", reverse split/\-/;' > datesPPZT.txt
i=1
for arg in $(cat param.txt | awk '{print $1}'); do
    dates=$(cat datesPPZT.txt | sed -n ''$i'p')
    dirpath=/backup/s3_logs/data/logs/$dates/common-gated-parking-parknow-$dates.log.gz
    result=$(zcat $dirpath | grep $arg | grep $var > /home/stepanenko/PPZT/logs/$arg.$dates.txt) #укажите свои директории
    echo "Выполнил за дату: $dates $arg"
    let i++
done

tar -cvf ppzt-logs.tar logs/

echo "Потрачено времени:"
time

