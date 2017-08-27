#! /bin/bash

# Install PHP-7
echo 'Installing PHP-7...'

# Install libxml2-devel
echo 'Installing libxml2-devel'

yum -y install libxml2-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install libxml2'
	stop
	exit 1
fi

