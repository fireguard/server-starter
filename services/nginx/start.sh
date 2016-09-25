#!/usr/bin/env bash
source /vagrant/scripts/functions.sh

FILELOG=$1
VERSION=$3

printHeader "Start Nginx Service"

INSTALED=$( checkIsInstaled nginx )

if [ "$INSTALED" == "false" ]; then
  printSuccess "Adding repository for Nginx"
  add-apt-repository ppa:nginx/stable -y >> "${FILELOG}" 2>&1

  printSuccess "Updating the packages archive to the server"
  apt-get update >> "${FILELOG}" 2>&1
  apt-get upgrade -y >> "${FILELOG}" 2>&1

  printSuccess "Install Nginx"
  apt-get install nginx -y >> "${FILELOG}" 2>&1
else
  printSuccess "Nginx is installed"
fi

cd /vagrant/hosts
for f in *.conf
do
	printSuccess "Link vHosts ${f}"
	FILENAME=$(echo $f | sed 's/.conf//g')
	cp -rf /vagrant/hosts/$f /etc/nginx/sites-available/${FILENAME}
	ln -sf /etc/nginx/sites-available/${FILENAME} /etc/nginx/sites-enabled/${FILENAME}
done

# restart apache
printSuccess "Restart Nginx Server"
service nginx restart >> "${FILELOG}" 2>&1
