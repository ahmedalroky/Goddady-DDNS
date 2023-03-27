#!/bin/bash


$domain = "" # example.com
$api = "" #api:secret
$host = "" # subdomain


result=$(curl -i -s -k -X $'GET' \
    -H $'Authorization: sso-key '$api'' -H $'Content-Type: application/json' -H $'User-Agent: PostmanRuntime/7.29.0' -H $'Accept: */*' -H $'Host: api.godaddy.com' -H $'Accept-Encoding: gzip, deflate' -H $'Connection: close'  \
    $'https://api.godaddy.com/v1/domains/'$domain'/records/A/'$host'')

#echo $result;

dnsIp=$(echo $result | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
#echo "dnsIp:" $dnsIp

# Get public ip address there are several websites that can do this.
ret=$(curl -s GET "http://ipinfo.io/json")
currentIp=$(echo $ret | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"|head -n 1|tr -d '\n')


#echo "currentIp:" $currentIp

if [ "$dnsIp" != "$currentIp" ];
 then
curl -i -s -k -X $'PUT' -H $'Authorization: sso-key '$api'' -H $'Content-Type: application/json' -H $'User-Agent: PostmanRuntime/7.29.0' -H $'Accept: */*' -H $'Host: api.godaddy.com' -H $'Accept-Encoding: gzip, deflate' -H $'Connection: close' --data-binary $'[    {        "data": "'$currentIp'",        "name": "'$host'",        "ttl": 1800,        "type": "A"    }]' $'https://api.godaddy.com/v1/domains/'$domain'/records/A/'$host''
fi

currentTime=$(date +"%Y-%m-%d %H:%M:%S")

# Log the IP address and time to a file
echo "$currentTime - $currentIp" >>  /var/log/godaddy.log
