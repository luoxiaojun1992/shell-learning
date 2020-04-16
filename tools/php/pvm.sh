#! /bin/bash

oldVersion=$1
newVersion=$2

echo 'Old version is '$oldVersion

echo 'New version is '$newVersion

if [ `php -v | grep 'PHP '${oldVersion} | wc -l` -eq 1 ]; then
	brew unlink php@${oldVersion}
fi

if [ `php -v | grep 'PHP '${newVersion} | wc -l` -eq 0 ]; then
	brew link --force php@${newVersion}
fi


