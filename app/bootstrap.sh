#!/bin/bash

# Composer install dependencies
/usr/local/bin/composer install

# Rename config files
if [ ! -e ./config/console-local.php ]
then
	cp ./config/console-local.php.sample ./config/console-local.php
fi

if [ ! -e ./config/elastic-settings-local.php ]
then
	cp ./config/elastic-settings-local.php.sample ./config/elastic-settings-local.php
fi

if [ ! -e ./config/params-local.php ]
then
	cp ./config/params-local.php.sample ./config/params-local.php
fi

# Main config + Redis (Move from temp location)
if [ ! -e ./config/main-local.php ]
then
	mv /main-local.php ./config/main-local.php
fi

if [ ! -e ./config/redis-connection-local.php ]
then
	mv /redis-connection-local.php ./config/redis-connection-local.php
fi

# Start DB migrations
./yii migrate --interactive=0

# Change permission for /runtime/logs
chmod 777 ./runtime
