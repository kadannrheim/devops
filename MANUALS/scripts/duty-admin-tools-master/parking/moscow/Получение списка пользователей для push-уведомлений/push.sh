#!/bin/bash


GRZ_FILE=$1

echo '' > resul.txt

echo '' > success.txt
for grz in $(cat $GRZ_FILE);
 do
   mongo 192.168.1.24/mskparking --quiet --eval "
   rs.secondaryOk();
   vrps = [$grz];
   db.authUsers.aggregate([{
       \$match: {
           \"vehicles.vrp\": {\$in: vrps}
       }
   }, {
       \$unwind: \"\$vehicles\"
   }, {
       \$match: {
           \"vehicles.vrp\": {\$in: vrps}
       }
   }, {
       \$project: {
           _id: 0,
           phones: 1,
           accountId: 1,
           vrp: \"\$vehicles.vrp\"
       }
   }, {
       \$sort: {
           vrp: 1
       }
   }]).map(({vrp, accountId, phones}) => (vrp+\"; \"+accountId+\"; \"+phones.join(', '))).join('\n')" >> resul.txt 
 done
#чистка пустых строк
sed '/^$/d' resul.txt > success.txt

