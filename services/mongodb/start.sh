#!/usr/bin/env bash
source /vagrant/scripts/functions.sh

FILELOG=$1
VERSION=$3

printHeader "Start MongoDB Service"

if ! grep -q "mongodb-org/3.4" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
  printSuccess "Adding repository for last version MongoDB"

  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 >> "${FILELOG}" 2>&1
  echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list >> "${FILELOG}" 2>&1

  printSuccess "Updating the repository packages"
  sudo apt-get update >> "${FILELOG}" 2>&1
fi

INSTALED=$( checkIsInstaled mongodb-org )
if [ "$INSTALED" == "false" ]; then
  printSuccess "Install MongoDB"
	apt-get -y install mongodb-org >> "${FILELOG}" 2>&1

  # replace config file my.cnf
  if [ -f "/vagrant/services/mongodb/mongod.conf" ]; then
    printSuccess "Replacing the default configuration file for mongod if there"
    cp -rf /vagrant/services/mongodb/mongod.conf /etc/mongod.conf >> "${FILELOG}" 2>&1
  fi
else
  printSuccess "MongoDB is installed"
fi

# For Remove
# sudo apt-get purge -y mongodb-org*
# sudo rm -r /var/log/mongodb
# sudo rm -r /var/lib/mongodb
# sudo rm -r /etc/apt/sources.list.d/mongodb-org-3.4.list
