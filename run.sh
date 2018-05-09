#!/bin/sh

/usr/bin/mysqld --user=root --console &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "status" > /dev/null 2>&1
    RET=$?
done

if [ -f /dump.sql ]; then
    mysql -uroot -p$MYSQL_ROOT_PASSWORD < /dump.sql
fi

$CATALINA_HOME/bin/catalina.sh run