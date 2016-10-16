#!/usr/bin/env bash

FILELOG=$1
VERSION=$3

source /vagrant/scripts/functions.sh

printHeader "Start NodeJs Service"

INSTALED=$( checkIsInstaled nodejs )
if [ "$INSTALED" == "false" ]; then
  if [ "$VERSION" == "6" ] || [ "$VERSION" == "default" ]; then
    printSuccess "Install NodeJs 6"
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - >> "${FILELOG}" 2>&1
    apt-get install -y nodejs >> "${FILELOG}" 2>&1
    apt-get install -y build-essential >> "${FILELOG}" 2>&1
    ln -s /usr/bin/nodejs /usr/bin/node

  elif [ "$VERSION" == "4" ]; then
    printSuccess "Install NodeJs 4"
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - >> "${FILELOG}" 2>&1
    apt-get install -y nodejs >> "${FILELOG}" 2>&1
    apt-get install -y build-essential >> "${FILELOG}" 2>&1
    ln -s /usr/bin/nodejs /usr/bin/node
  else
    printError "${VERSION} is not valid"
  fi
else
  printSuccess "NodeJs is installed"
fi
