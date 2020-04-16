#! /bin/bash

# yum            Update notifiction

# Author:        Xiaojun Luo

# chkconfig:     345 97 03

# description:   Update yum packages

# processname:   yum-updatesd

# config:        /etc/yum/yum-updatesd.conf

# pidfile:       /var/run/yum-updatesd.pid

### BEGIN INIT INFO

# Provides: yum-updatesd

# Required-Start: $syslog $local_fs messagebus

# Required-Stop: $syslog $local_fs messagebus

# Default-Start: 2 3 4 5

# Default-Stop: 0 1 6

# Short-Description: Update Daemon

# Description: Update Daemon

### END INIT INFO

. /etc/rc.d/init.d/functions

RETVAL=0

start() {

}

stop() {

}

restart() {

}

exit $RETVAL
