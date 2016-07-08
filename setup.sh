#!/usr/bin/env bash

echo "Start setup..."

read -p "Your MySQL username : "  mysql_username
read -p "Your MySQL password : "  mysql_password
read -p "Your MySQL database : "  mysql_database_name

cp .env.testing .env
sed -i -e "s/DB_DATABASE=homestead/DB_DATABASE=$mysql_database_name/g" .env
sed -i -e "s/DB_USERNAME=homestead/DB_USERNAME=$mysql_username/g" .env
sed -i -e "s/DB_PASSWORD=secret/DB_PASSWORD=$mysql_password/g" .env
sed -i -e "s/SESSION_DRIVER=file/SESSION_DRIVER=redis/g" .env

mysql -u$mysql_username -p$mysql_password -e "create database $mysql_database_name;"

touch storage/logs/laravel.log
chmod -R 777 storage
composer install
php artisan migrate
php artisan db:seed
php artisan key:generate

echo "Done."
