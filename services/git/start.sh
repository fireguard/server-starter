#!/usr/bin/env bash
source /vagrant/scripts/functions.sh

FILELOG=$1
VERSION=$3
USER_NAME_GIT=$4
EMAIL_GIT=$5

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

INSTALED=$( checkIsInstaled git-flow )
if [ "$INSTALED" == "false" ]; then

  printSuccess "Install Git Flow"
	apt-get -y install git-flow >> "${FILELOG}" 2>&1

else
  printSuccess "Git Flow is installed"
fi

printSuccess "Configuring Git Client : ${USER_NAME_GIT} <${EMAIL_GIT}>"
git config --global user.email "${EMAIL_GIT}" >> "${FILELOG}" 2>&1
git config --global user.name "${USER_NAME_GIT}" >> "${FILELOG}" 2>&1
