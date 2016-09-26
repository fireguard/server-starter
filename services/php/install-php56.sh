#!/usr/bin/env bash



function phpInstall {
  FILELOG=$1

  apt-get purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "` >> "${FILELOG}" 2>&1

  printSuccess "Adding repository for version 5.6 of the PHP"
  add-apt-repository ppa:ondrej/php -y >> "${FILELOG}" 2>&1

  printSuccess "Updating the packages archive to the server"
  apt-get update >> "${FILELOG}" 2>&1
  apt-get upgrade -y >> "${FILELOG}" 2>&1

  printSuccess "Install php5.6 and clients"
  apt-get install -y php5.6 php5.6-fpm php5.6-cli php5.6-common php5.6-dev >> "${FILELOG}" 2>&1

  # enable module CURL, necessário para usar o servidor S3
  printSuccess "Install module php5.6-curl "
  apt-get install -y php5.6-curl >> "${FILELOG}" 2>&1

  printSuccess "Install module php5.6-mcrypt"
  apt-get install -y php5.6-mcrypt >> "${FILELOG}" 2>&1

  printSuccess "Install module php5.6-gd"
  apt-get install php5.6-gd >> "${FILELOG}" 2>&1

  printSuccess "Install module php5.6-xdebug"
  apt-get install php5.6-xdebug >> "${FILELOG}" 2>&1

  printSuccess "Install module php5.6-mysql"
  apt-get install php5.6-mysql >> "${FILELOG}" 2>&1


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
