#!/bin/bash

if [ ! -f /var/lib/mysql/.initialized ]; then
	service mariadb start

    sleep 5

	mariadb << EOF
	CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
	CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	FLUSH PRIVILEGES;
EOF

	mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown
	touch /var/lib/mysql/.initialized
fi

mysqld_safe