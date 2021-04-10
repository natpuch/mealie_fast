#!/bin/bash

function add_var () {
	name=$(echo $1 | sed -e 's/PASS_//')
	val=$(eval echo \$$1)
	echo "export $name=$val" >> /etc/apache2/envvars
	sed  -i "/\[Service\]/a Environment=$name=$val" /lib/systemd/system/apache2.service
	sed -i "/DocumentRoot/a PassEnv $name" /etc/apache2/sites-available/000-default.conf
}


chown -R www-data /var/www/
cd /var/www/html/
build.sh

pass_var=$(env | cut -d= -f1 | grep PASS_)

for var in $pass_var; do
	add_var $var
done

service apache2 start
tail -f /dev/null
