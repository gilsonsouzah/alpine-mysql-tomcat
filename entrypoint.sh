#!/bin/sh

if [ -d /app/mysql ]; then
    echo "[i] MySQL directory already present, skipping creation"
else
    echo "[i] MySQL data directory not found, creating initial DBs"

    mysql_install_db --user=root > /dev/null

    if [ "$MYSQL_PASSWORD" = "" ]; then
    MYSQL_PASSWORD=47PY7rpS5wfprCtY5nvvqxYD2GU
    echo "[i] MySQL admin Password: $MYSQL_PASSWORD"
    fi

    MYSQL_DATABASE=${MYSQL_DATABASE:-""}

    if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    fi

    /usr/bin/mysqld_safe --user=root --bootstrap > /dev/null 2>&1 &

    RET=1
    while [[ RET -ne 0 ]]; do
      echo "[i] Waiting for confirmation of MySQL service startup"
      sleep 5
      mysql -uroot -e "status" > /dev/null 2>&1
      RET=$?
    done

    echo "[i]  Creating MySQL admin user with ${MYSQL_PASSWORD} password"

    mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

    if [ "$MYSQL_DATABASE" = "" ]; then
    echo "[i]  Creating MySQL database with name ${MYSQL_DATABASE}"
    mysql -uroot -e "CREATE SCHEMA '$MYSQL_DATABASE'"
    fi

    if [ -f /dump.sql ] ; then
      echo "[i] Initial script found, running"
      mysql -uadmin -p$MYSQL_PASSWORD
    fi

    echo "=> Done!"

    echo "========================================================================"
    echo "You can now connect to this MySQL Server using:"
    echo ""
    echo "    mysql -uadmin -p$MYSQL_PASSWORD -h<host> -P<port>"
    echo ""
    echo "Please remember to change the above password as soon as possible!"
    echo "MySQL user 'root' has no password but only allows local connections"
    echo "========================================================================"

    mysqladmin -uroot shutdown
fi



exec "$@"
