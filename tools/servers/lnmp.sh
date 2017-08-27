#! /bin/bash

install_php7() {
# Install PHP-7
echo 'Installing PHP-7...'

# Install libxml2-devel
echo 'Installing libxml2-devel'

yum -y install libxml2-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install libxml2-devel'
	return 1
fi

# Install openssl-devel
echo 'Installing openssl-devel'

yum -y install openssl-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install openssl-devel'
	return 1
fi

# Install libjpeg-devel
echo 'Installing libjpeg-devel'

yum -y install libjpeg-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install libjpeg-devel'
	return 1
fi

# Install libpng-devel
echo 'Installing libpng-devel'

yum -y install libpng-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install libpng-devel'
	return 1
fi

# Install freetype-devel
echo 'Installing freetype-devel'

yum -y install freetype-devel

if [ $? -ne 0 ]; then
	echo 'Failed to install freetype-devel'
	return 1
fi

# Download PHP-7
wget https://downloads.php.net/~remi/php-7.2.0beta3.tar.gz
if [ $? -ne 0 ]; then
	echo 'Failed to download PHP-7'
	return 1
fi

# Extract PHP-7
tar -zxvf php-7.2.0beta3.tar.gz
if [ $? -ne 0 ]; then
	echo 'Failed to extract PHP-7'
	return 1
fi

cd php-7.2.0beta3

# Configure PHP-7
./configure --with-mcrypt=/usr/include --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-gd --with-iconv --with-zlib --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --enable-mbregex --enable-fpm --enable-mbstring --enable-ftp --enable-gd-native-ttf --with-openssl --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --without-pear --with-gettext --enable-session --with-curl --with-jpeg-dir --with-freetype-dir --enable-opcache

if [ $? -ne 0 ]; then
	echo 'Failed to configure PHP-7'
	return 1
fi

# Make PHP-7
make
if [ $? -ne 0 ]; then
	echo 'Failed to make PHP-7'
	return 1
fi

# Install PHP-7
make install
if [ $? -ne 0 ]; then
	echo 'Failed to install PHP-7'
	return 1
fi

echo 'PHP-7 installed'

# PHP-7 Configuration
cp php.ini-production /usr/local/lib/php.ini
cp /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
cp /usr/local/etc/php-fpm.d/www.conf.default /usr/local/etc/php-fpm.d/www.conf

if [ ! -d /usr/local/log ]; then
	mkdir -p /usr/local/log
fi

sed -i 's/NONE/\/usr\/local/g' /usr/local/etc/php-fpm.conf
if [ $? -ne 0 ]; then
	echo 'Failed to init php-fpm.conf'
	return 1
fi

php-fpm -y /usr/local/etc/php-fpm.conf -c /usr/local/lib/php.ini
if [ $? -ne 0 ]; then
	echo 'Failed to start php-fpm'
	return 1
fi

return 0
}

install_php7
if [ $? -eq 0 ]; then
	echo 'PHP-7 installed'
else
	echo 'Failed to install PHP-7'
fi
