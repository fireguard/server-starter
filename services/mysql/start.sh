#!/usr/bin/env bash
source /vagrant/scripts/functions.sh

FILELOG=$1
VERSION=$3
PASSWORD=$4

printHeader "Start MySQL Service"

if [ "$VERSION" == "5.7" ] || [ "$VERSION" == "default" ]; then
  INSTALED=$( checkIsInstaled mysql-server-5.7 )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install MySQL 5.7"
    source /vagrant/services/mysql/install-mysql57.sh
    mysqlInstall $FILELOG $PASSWORD
    printSuccess "Finish Install MySQL 5.7"
  else
      printSuccess "MySQL 5.7 is installed"
  fi
else
  printError "${VERSION} is not valid"
fi
