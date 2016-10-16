#!/usr/bin/env bash

FILELOG=$1
VERSION=$3
PACKAGES=$4

source /vagrant/scripts/functions.sh

printHeader "Start Ruby Service"

INSTALED=$( checkIsInstaled ruby-full )
if [ "$INSTALED" == "false" ]; then
    printSuccess "Install Ruby"
    apt-get install -y ruby-full >> "${FILELOG}" 2>&1
    gem update --system >> "${FILELOG}" 2>&1

    if [ -z "$PACKAGES" ]; then
      printSuccess "Not Packages for Install"
    else
      printSuccess "Install Packages ( ${PACKAGES} )"
      gem install ${PACKAGES} >> "${FILELOG}" 2>&1
    fi
else
  printSuccess "Ruby is installed"
fi
