#! /bin/bash

host=$1
if [ $# -lt 1 ]; then
    host='127.0.0.1'
fi

while :
do
ping $host -c 3
timestamp=$(date +%Y-%m-%d\ %H:%M:%S)
if [ $? -eq 0 ]; then
    echo "$timestamp:Status On"
else
    echo "$timestamp:Status Off"
fi
sleep 5
done

