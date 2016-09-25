#!/usr/bin/env bash

function phpInstall {
  FILELOG=$1

  apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "` >> "${FILELOG}" 2>&1

  printSuccess "Adding repository for version 7.0 of the PHP"
  add-apt-repository ppa:ondrej/php -y >> "${FILELOG}" 2>&1

  printSuccess "Updating the packages archive to the server"
  apt-get update >> "${FILELOG}" 2>&1
  apt-get upgrade -y >> "${FILELOG}" 2>&1

  printSuccess "Install php7.0 and clients"
  apt-get install -y php7.0 php7.0-fpm php7.0-cli php7.0-common php7.0-dev >> "${FILELOG}" 2>&1

  # enable module CURL, necessário para usar o servidor S3
  printSuccess "Install module php7.0-curl "
  apt-get install -y php7.0-curl >> "${FILELOG}" 2>&1

  printSuccess "Install module php7.0-mcrypt"
  apt-get install -y php7.0-mcrypt >> "${FILELOG}" 2>&1

  printSuccess "Install module php7.0-gd"
  apt-get install php7.0-gd >> "${FILELOG}" 2>&1

  printSuccess "Install module php7.0-xdebug"
  apt-get install php7.0-xdebug >> "${FILELOG}" 2>&1

  return 0
}
