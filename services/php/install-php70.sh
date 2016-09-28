#!/usr/bin/env bash

function phpInstall {
  FILELOG=$1

  INSTALED=$( checkIsInstaled php5.6 )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "No old versions detected"
  else
    printSuccess "Remove old versions"
    apt-get purge -y `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "` >> "${FILELOG}" 2>&1
  fi

  if ! grep -q "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    printSuccess "Adding repository for version 7.0 of the PHP"
    add-apt-repository ppa:ondrej/php -y >> "${FILELOG}" 2>&1

    printSuccess "Updating the packages archive to the server"
    apt-get update >> "${FILELOG}" 2>&1
    apt-get upgrade -y >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0 )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install php7.0"
    apt-get install -y php7.0 >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-fpm )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install php7.0-fpm"
    apt-get install -y php7.0-fpm >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-cli )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-cli"
    apt-get install -y php7.0-cli >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-common )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-common"
    apt-get install -y php7.0-common >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-dev )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-dev"
    apt-get install -y php7.0-dev >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-curl )
  if [ "$INSTALED" == "false" ]; then
    # enable module CURL, necessário para usar o servidor S3
    printSuccess "Install module php7.0-curl "
    apt-get install -y php7.0-curl >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-mcrypt )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-mcrypt"
    apt-get install -y php7.0-mcrypt >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-gd )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-gd"
    apt-get install php7.0-gd >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-xdebug )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-xdebug"
    apt-get install php7.0-xdebug >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-mysql )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-mysql"
    apt-get install php7.0-mysql >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php7.0-mbstring )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php7.0-mbstring"
    apt-get install php7.0-mbstring >> "${FILELOG}" 2>&1
  fi

  return 0
}
