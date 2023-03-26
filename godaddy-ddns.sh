#!/bin/bash



result=$(curl -i -s -k -X $'GET' \
    -H $'Authorization: sso-key api:secret' -H $'Content-Type: application/json' -H $'User-Agent: PostmanRuntime/7.29.0' -H $'Accept: */*' -H $'Postman-Token: f85ab54d-fb32-4e2c-aff3-959cda3ccd66' -H $'Host: api.godaddy.com' -H $'Accept-Encoding: gzip, deflate' -H $'Connection: close' -H $'Content-Length: 116' \
    --data-binary $'[    {        "data": "10.10.10.10",        "name": "vm",        "ttl": 1800,        "type": "A"    }]' \
    $'https://api.godaddy.com/v1/domains/YOUR_DOMAIN/records/A/vm')

#echo $result;

dnsIp=$(echo $result | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
#echo "dnsIp:" $dnsIp

# Get public ip address there are several websites that can do this.
ret=$(curl -s GET "http://ipinfo.io/json")
currentIp=$(echo $ret | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -n 1|tr -d '\n')


#echo "currentIp:" $currentIp

if [ "$dnsIp" != "$currentIp" ];
 then
curl -i -s -k -X $'PUT' -H $'Authorization: sso-key api:secret' -H $'Content-Type: application/json' -H $'User-Agent: PostmanRuntime/7.29.0' -H $'Accept: */*' -H $'Postman-Token: 58633b35-749b-4548-bf6c-170024973dbb' -H $'Host: api.godaddy.com' -H $'Accept-Encoding: gzip, deflate' -H $'Connection: close' --data-binary $'[    {        "data": "'$currentIp'",        "name": "vm",        "ttl": 1800,        "type": "A"    }]' $'https://api.godaddy.com/v1/domains/YOUR_DOMAIN/records/A/vm'
fi

currentTime=$(date +"%Y-%m-%d %H:%M:%S")

# Log the IP address and time to a file
echo "$currentTime - $currentIp" >>  /var/log/godaddy.log
