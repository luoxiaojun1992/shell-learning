#! /bin/bash

SHOW_DATABASES_SQL='show databases'

mysql -uroot -e "$SHOW_DATABASES_SQL"

echo 'select @@sql_mode' | mysql -uroot

mysql -uroot <<EOF
show databases;
EOF
