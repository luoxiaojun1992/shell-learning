#! /bin/bash

while read LINE
do
    username=`echo $LINE | cut -f1 -d ' '`
    password=`echo $LINE | cut -f2 -d ' '`
    echo -n "username:$username,"
    echo "password:$password"
    useradd $username
    if [ $? -ne 0 ];then
    	echo 'User exists or error'
    else
	echo $password | passwd --stdin $username
    fi
done < $1

