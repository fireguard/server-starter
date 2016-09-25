#!/usr/bin/env bash
source /vagrant/scripts/functions.sh

FILELOG=$1

printHeader "Start Git Service"

if ! grep -q "git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/*; then

  printSuccess "Adding repository for last version git"
  apt-add-repository ppa:git-core/ppa -y >> "${FILELOG}" 2>&1

  printSuccess "Updating the repository packages"
  sudo apt-get update >> "${FILELOG}" 2>&1

fi

INSTALED=$( checkIsInstaled git )
if [ "$INSTALED" == "false" ]; then

  printSuccess "Install Git"
	apt-get -y install git >> "${FILELOG}" 2>&1

else
  printSuccess "Git is installed"
fi
