#!/usr/bin/env bash

FILELOG=$1
VERSION=$3

source /vagrant/scripts/functions.sh

printHeader "Start PHP Service"

if [ "$VERSION" == "7.0" ] || [ "$VERSION" == "default" ]; then
  source /vagrant/services/php/install-php70.sh
  phpInstall FILELOG

elif [ "$VERSION" == "5.6" ]; then
  source /vagrant/services/php/install-php56.sh
  phpInstall FILELOG

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
