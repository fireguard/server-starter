#!/usr/bin/env bash

function phpInstall {
  FILELOG=$1

  INSTALED=$( checkIsInstaled php7.0 )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "No others versions detected"
  else
    printSuccess "Remove others versions"
    apt-get purge -y `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "` >> "${FILELOG}" 2>&1
  fi

  if ! grep -q "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    printSuccess "Adding repository for version 5.6 and 7.0 of the PHP"
    add-apt-repository ppa:ondrej/php -y >> "${FILELOG}" 2>&1

    printSuccess "Updating the packages archive to the server"
    apt-get update >> "${FILELOG}" 2>&1
    apt-get upgrade -y >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6 )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install php5.6"
    apt-get install -y php5.6 >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-fpm )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install php5.6-fpm"
    apt-get install -y php5.6-fpm >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-cli )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-cli"
    apt-get install -y php5.6-cli >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-common )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-common"
    apt-get install -y php5.6-common >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-dev )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-dev"
    apt-get install -y php5.6-dev >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-curl )
  if [ "$INSTALED" == "false" ]; then
    # enable module CURL, necessário para usar o servidor S3
    printSuccess "Install module php5.6-curl "
    apt-get install -y php5.6-curl >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-mcrypt )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-mcrypt"
    apt-get install -y php5.6-mcrypt >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-gd )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-gd"
    apt-get install php5.6-gd >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-xdebug )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-xdebug"
    apt-get install php5.6-xdebug >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-mysql )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-mysql"
    apt-get install php5.6-mysql >> "${FILELOG}" 2>&1
  fi

  INSTALED=$( checkIsInstaled php5.6-mbstring )
  if [ "$INSTALED" == "false" ]; then
    printSuccess "Install module php5.6-mbstring"
    apt-get install php5.6-mbstring >> "${FILELOG}" 2>&1
  fi


  #php5enmod xdebug >> "${FILELOG}" 2>&1

  # enable php mcrypt
  # php5enmod mcrypt >> "${FILELOG}" 2>&1
  # replace config file php.ini
  # if [ -f "/vagrant/services/php/php56.ini" ]; then
  #   printSuccess "Replacing the default configuration file for php.ini if there"
  #   if [ -d "/etc/php5/apache2" ]; then
  #     cp -rf /vagrant/services/php/php56.ini /etc/php5/apache2/php.ini >> "${FILELOG}" 2>&1
  #   fi
  #
  #   if [ -d "/etc/php5/apache2" ]; then
  #     cp -rf /vagrant/services/php/php56.ini /etc/php5/apache2/php.ini >> "${FILELOG}" 2>&1
  #   fi
  #
  # fi

  return 0
}
