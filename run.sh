#!/bin/sh


if [ -f /dump.sql ]; then
    echo "[i] Init file found: Loading database with initial script"
    /usr/bin/mysqld --user=root --init-file=/dump.sql --console & $CATALINA_HOME/bin/catalina.sh run
else
    echo "[i] Init file NOT found: Loading database ONLY"
    /usr/bin/mysqld --user=root --console & $CATALINA_HOME/bin/catalina.sh run
fi

