#! /bin/bash

# Usage
# flock -xn /tmp/lnmp-install.lock -c 'sudo nohup ./lnmp.sh >> ~/lnmp-install.log 2>&1 &'

install_nginx1121() {
	echo 'Installing nginx1.12.1...'

	rm -rf ~/nginx-1.12.1.tar.gz
	rm -rf ~/nginx-1.12.1
	rm -rf /usr/local/nginx
	kill `ps aux|grep nginx | awk '{print $2}'`

	# Install dependencies
	yum -y install zlib zlib-devel openssl openssl-devel pcre pcre-devel
	if [ $? -ne 0 ]; then
		echo 'Failed to install dependencies of nginx1.12.1'
		return 1
	fi

	wget http://nginx.org/download/nginx-1.12.1.tar.gz
	if [ $? -ne 0 ]; then
		echo 'Failed to download nginx1.12.1'
		return 1
	fi

	tar -zxvf ~/nginx-1.12.1.tar.gz
	if [ $? -ne 0 ]; then
		echo 'Failed to extract nginx1.12.1'
		return 1
	fi

	cd ~/nginx-1.12.1

	./configure
	if [ $? -ne 0 ]; then
		echo 'Failed to configure nginx1.12.1'
		return 1
	fi

	make
	if [ $? -ne 0 ]; then
		echo 'Failed to make nginx1.12.1'
		return 1
	fi

	make install
	if [ $? -ne 0 ]; then
		echo 'Failed to install nginx1.12.1'
		return 1
	fi
	
	# Enable TCP_CORK/TCP_NOPUSH
	sed -i '1,$s/#tcp_nopush     on;/tcp_nopush     on;/g' /usr/local/nginx/conf/nginx.conf	
	if [ $? -ne 0 ]; then
		echo 'Failed to enable TCP_CORK'
		return 1
	fi

	# Modify Keepalive Timeout
	sed -i '1,$s/keepalive_timeout  65;/keepalive_timeout  60;/g' /usr/local/nginx/conf/nginx.conf
	if [ $? -ne 0 ]; then
		echo 'Failed to modify keepalive timeout'
		return 1
	fi

	/usr/local/nginx/sbin/nginx
	if [ $? -ne 0 ]; then
		echo 'Failed to start nginx1.12.1'
		return 1
	fi

	return 0
}

install_mysql57() {
	echo 'Installing mysql57...'

	service mysqld stop
	yum -y remove mysql-community-server
	rm -rf ~/mysql57-community-release-el7-11.noarch.rpm

	wget https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
	if [ $? -ne 0 ]; then
		echo 'Failed to download mysql57'
		return 1
	fi

	rpm -Uvh ~/mysql57-community-release-el7-11.noarch.rpm
	yum -y install mysql-community-server
	if [ $? -ne 0 ]; then
		echo 'Failed to install mysql57'
		return 1 
	fi

	service mysqld start
	if [ $? -ne 0 ]; then
		echo 'Failed to start mysql57'
		return 1 
	fi
	
	return 0
}

install_php7() {
# Install PHP-7
echo 'Installing PHP-7...'

# Clear Old PHP-7
rm -rf ~/php-7.2.0beta3
rm -rf ~/php-7.2.0beta3.tar.gz
rm -rf /usr/local/php
rm -rf /usr/local/lib/php
kill `ps aux|grep php-fpm | awk '{print $2}'`

# Install dpkg
echo 'Installing dpkg'
yum -y install dpkg
if [ $? -ne 0 ]; then
	echo 'Failed to install dpkg'
	return 1
fi

# Install curl-devel
echo 'Installing curl-devel'
yum -y install curl-devel
if [ $? -ne 0 ]; then
	echo 'Failed to install curl-devel'
	return 1
fi

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
if [ ! -f ~/php-7.2.0beta3.tar.gz ]; then
	wget https://downloads.php.net/~remi/php-7.2.0beta3.tar.gz
fi
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
if [ ! -f /usr/local/lib/php.ini ]; then
	cp php.ini-production /usr/local/lib/php.ini
fi
if [ ! -f /usr/local/etc/php-fpm.conf ]; then
	cp /usr/local/etc/php-fpm.conf.default /usr/local/etc/php-fpm.conf
fi
if [ ! -f /usr/local/etc/php-fpm.d/www.conf ]; then
	cp /usr/local/etc/php-fpm.d/www.conf.default /usr/local/etc/php-fpm.d/www.conf
fi

if [ ! -d /usr/local/log ]; then
	mkdir -p /usr/local/log
fi

sed -i 's/NONE/\/usr\/local/g' /usr/local/etc/php-fpm.conf
if [ $? -ne 0 ]; then
	echo 'Failed to init php-fpm.conf'
	return 1
fi

sed -i '1,$s/pm = dynamic/pm = static/g' /usr/local/etc/php-fpm.d/www.conf
if [ $? -ne 0 ]; then
	echo 'Failed to optimize php-fpm.conf'
	return 1
fi

sed -i '1,$s/pm.max_children = 5/pm.max_children = 32/g' /usr/local/etc/php-fpm.d/www.conf
if [ $? -ne 0 ]; then
	echo 'Failed to optimize php-fpm.conf'
	return 1
fi

sed -i '1,$s/;request_terminate_timeout = 0/request_terminate_timeout = 5s/g' /usr/local/etc/php-fpm.d/www.conf
if [ $? -ne 0 ]; then
	echo 'Failed to optimize php-fpm.conf'
	return 1
fi

sed -i '1,$s/max_execution_time = 30/max_execution_time = 5/g' /usr/local/lib/php.ini
if [ $? -ne 0 ]; then
	echo 'Failed to optimize php.ini'
	return 1
fi

sed -i '1,$s/;request_slowlog_timeout = 0/request_slowlog_timeout = 1s/g' /usr/local/etc/php-fpm.d/www.conf
if [ $? -ne 0 ]; then
	echo 'Failed to optimize php-fpm.conf'
	return 1
fi

sed -i '1,$s/;slowlog = log\/$pool.log.slow/slowlog = log\/$pool.log.slow/g' /usr/local/etc/php-fpm.d/www.conf
if [ $? -ne 0 ]; then
	echo 'Failed to optimize php-fpm.conf'
	return 1
fi

/usr/local/sbin/php-fpm -y /usr/local/etc/php-fpm.conf -c /usr/local/lib/php.ini
if [ $? -ne 0 ]; then
	echo 'Failed to start php-fpm'
	return 1
fi

return 0
}

cd ~
install_nginx1121

if [ $? -eq 0 ]; then
	echo 'Nginx1.12.1 installed'
else
	echo 'Failed to install Nginx1.12.1'
fi

#cd ~
#install_mysql57

#if [ $? -eq 0 ]; then
#	echo 'mysql57 installed'
#else
#	echo 'Failed to install mysql57'
#fi

cd ~
install_php7

if [ $? -eq 0 ]; then
	echo 'PHP-7 installed'
else
	echo 'Failed to install PHP-7'
fi

cd ~
