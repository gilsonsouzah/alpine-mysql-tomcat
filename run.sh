#!/bin/sh

# /usr/bin/mysqld_safe --user=root & $CATALINA_HOME/bin/catalina.sh run
# /usr/bin/mysqld --user=root  & $CATALINA_HOME/bin/catalina.sh run
# /entrypoint.sh & /usr/bin/mysqld --user=root  & $CATALINA_HOME/bin/catalina.sh run
/entrypoint.sh & $CATALINA_HOME/bin/catalina.sh run