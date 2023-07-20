#!/bin/bash

echo "" > result.txt
echo "" > done.txt

STARTDATE=$1
ENDDATE=$2
API=/auth/api/1.0/pincodes

DIFF=$(echo $(( ($(date -d "$ENDDATE" +%s)-$(date -d "$STARTDATE" +%s))/86400 )))
echo "Разница в днях $DIFF"

for i in $(seq 0 $DIFF); do
    CURR=$(date -d "$STARTDATE +${i} days" "+%Y-%m-%d")
    filename=$(echo "/backup/s3_logs/data/logs/$CURR/*-parking-frontend-$CURR.log.gz")
    echo "Чтение файла за дату $CURR"
    zcat $filename | grep "$API 204" | sed 's,.*x-client-info":"\([^*"]*\).*phone":"\([0-9]*\).*,\1 \2,' >> result.txt
done

cat result.txt | sort -rh | uniq -c | sort -rh > done.txt
