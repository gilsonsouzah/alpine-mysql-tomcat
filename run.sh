#!/bin/sh

# sh /startup.sh && sh catalina.sh run

/usr/local/mysql/bin/mysqld_safe --user=root & /catalina.sh run
