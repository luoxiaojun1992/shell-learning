#! /bin/bash

DIRS="/bin /usr/bin"

FIND=/usr/bin/find

MD5SUM=/usr/bin/md5sum

MD5FILE=md5sum.md5

$FIND $DIRS -type f | while read line
do
    $MD5SUM $line >> $MD5FILE
done

