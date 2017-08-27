#! /bin/bash

# Install PHP-7
echo 'Installing PHP-7...'

# Install libxml2-devel
echo 'Installing libxml2-devel'

yum -y install libxml2-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install libxml2-devel'
	exit 1
fi

# Install openssl-devel
echo 'Installing openssl-devel'

yum -y install openssl-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install openssl-devel'
	exit 1
fi

# Install libjpeg-devel
echo 'Installing libjpeg-devel'

yum -y install libjpeg-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install libjpeg-devel'
	exit 1
fi

# Install libpng-devel
echo 'Installing libpng-devel'

yum -y install libpng-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install libpng-devel'
	exit 1
fi

# Install freetype-devel
echo 'Installing freetype-devel'

yum -y install freetype-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install freetype-devel'
	exit 1
fi

