#!/usr/bin/env bash

FILELOG=$1
VERSION=$3

source /vagrant/scripts/functions.sh

printHeader "Start NPM Service"

INSTALED=$( checkIsInstaled npm )
if [ "$INSTALED" == "false" ]; then
  printSuccess "Install NPM"
    apt-get install -y npm >> "${FILELOG}" 2>&1
else
  printSuccess "NPM is installed"
fi
