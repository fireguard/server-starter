#!/usr/bin/env bash

FILELOG=$1
VERSION=$3

source /vagrant/scripts/functions.sh

printHeader "Start PHP Service"

if [ "$VERSION" == "7.0" ] || [ "$VERSION" == "default" ]; then

  INSTALED=$( checkIsInstaled php7.0 )
  if [ "$INSTALED" == "false" ]; then
    source /vagrant/services/php/install-php70.sh
    phpInstall FILELOG
  else
    printSuccess "PHP 7.0 is installed"
  fi
elif [ "$VERSION" == "5.6" ]; then
  INSTALED=$( checkIsInstaled php5.6 )
  if [ "$INSTALED" == "false" ]; then
    source /vagrant/services/php/install-php56.sh
    phpInstall FILELOG
  else
    printSuccess "PHP 5.6 is installed"
  fi
else
  printError "${VERSION} is not valid"
fi

# Generate default php page
if [ -f "/projects/index.php" ]; then
  printSuccess "Index file exist"
else
  printSuccess "Create default file for the Web Server"
  echo "<?= phpinfo();  ?>" > /projects/index.php
fi
