#! /bin/bash

SHOW_DATABASES_SQL='show databases'

mysql -uroot -e "$SHOW_DATABASES_SQL"
