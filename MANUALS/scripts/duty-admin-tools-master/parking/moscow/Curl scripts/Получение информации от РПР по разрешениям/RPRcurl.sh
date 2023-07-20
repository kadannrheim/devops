#!/bin/bash

for NUM in $(cat numbers.txt | awk '{print $1}'); do

curl -v  --location --request POST 'http://10.159.206.123:80/services/ws/ParkingService' --header 'Accept: */*' --header 'Accept-Encoding: gzip, deflate' --header 'Authorization: Basic bXNrLXBwOjJOdll2cnlmd0EzMWFzek81czRY' --header 'Cache-Control: no-cache' --header 'Connection: keep-alive' --header 'Content-Type: text/xml' --header 'SOAPAction: http://asguf.mos.ru/rkis_gu/parkings/IService/getParkings' --data '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:par="http://asguf.mos.ru/rkis_gu/parkings/">
    <soapenv:Header/>
    <soapenv:Body>
        <par:findParkings>
           <par:req>
                <par:LicenseNum>0033366-2023</par:LicenseNum>
            </par:req>                                      
        </par:findParkings>
    </soapenv:Body>
</soapenv:Envelope>' > result.xml 

xmllint --format result.xml > results/$NUM.xml
sleep 10

done

