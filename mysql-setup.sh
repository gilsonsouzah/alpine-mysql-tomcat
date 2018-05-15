if [ -f /dump.sql ] ; then
  echo "[i] Initial script found, running"
  mysql -uadmin -p$MYSQL_PASSWORD < /dump.sql
fi