#!bin/bash

while :
        do
           D=$(date +%s)
           POD=$(kubectl get po -n parking  | grep -E 'rel[0-9]{2}-sbp-payment-yoo' | grep Running | awk {'print $1'})
           DD=$(($D*10**3))

           kubectl -n parking exec -it $POD -- bash -c "curl --request POST --url \"http://127.0.0.1:3402/api/repeat?startDate=$DD\" > /tmp/$DD.txt"

           sleep 10
           kubectl -n parking cp $POD:/tmp/$DD.txt /home/stepanenko/script-result/$DD.txt
done
