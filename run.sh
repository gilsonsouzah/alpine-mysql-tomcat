#!/bin/sh
echo "=> Starting MySQL Daemon process"
rc-service mariadb start

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "status" > /dev/null 2>&1
    RET=$?
done

if [ -f /dump.sql ]; then
    echo "=> Dump file found, seeding database"
    mysql -uroot -p$MYSQL_ROOT_PASSWORD < /dump.sql
fi

$CATALINA_HOME/bin/catalina.sh run