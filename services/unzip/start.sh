#!/usr/bin/env bash
source /vagrant/scripts/functions.sh

FILELOG=$1

printHeader "Start Unzip Service"

INSTALED=$( checkIsInstaled unzip )
if [ "$INSTALED" == "false" ]; then

  printSuccess "Install Unzip"
  apt-get install -y unzip >> "${FILELOG}" 2>&1

else
  printSuccess "Unzip is installed"
fi
