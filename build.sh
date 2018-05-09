#!/bin/sh

if [ -f /dump.sql ]; then
    echo "[i] Dump found: Loading dump into database"
    /usr/bin/mysql -uroot -p$MYSQL_ROOT_PASSWORD < /dump.sql
fi

$CATALINA_HOME/bin/catalina.sh run