#!/bin/bash
# sleep 10
if [ ! -f wp-config.php ]; then

	# Wait for MariaDB to be ready
	until mysqladmin ping -h"$DB_HOST" -P"$DB_HOST_PORT" --silent; do
		echo "Waiting for MariaDB to be ready..."
		sleep 2
	done

	wp core download --allow-root	

	wp config create \
	--dbname="$MYSQL_DATABASE" \
	--dbuser="$MYSQL_USER" \
	--dbpass="$MYSQL_PASSWORD" \
	--dbhost="$DB_HOST:$DB_HOST_PORT" \
	--allow-root

	wp core install \
	--url="$DOMAINE/" \
	--title="$TITLE" \
	--admin_user="$WORDPRESS_ADMIN_USER" \
	--admin_password="$WORDPRESS_ADMIN_PASS" \
	--admin_email=$WORDPRESS_ADMIN_EMAIL \
	--skip-email \
	--allow-root

	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
    --user_pass=$WORDPRESS_USER_PASS \
    --allow-root

fi	

/usr/sbin/php-fpm8.2 -F