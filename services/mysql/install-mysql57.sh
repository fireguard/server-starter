#!/usr/bin/env bash

function mysqlInstall {
  FILELOG=$1
  PASSWORD=$2

  printSuccess "Clear old versions Mysql Server"
  apt-get purge -y `dpkg -l | grep mysql-server| awk '{print $2}' |tr "\n" " "` >> "${FILELOG}" 2>&1
  apt-get purge -y `dpkg -l | grep mysql-client| awk '{print $2}' |tr "\n" " "` >> "${FILELOG}" 2>&1
  apt-get purge -y mysql-client mysql-common dbconfig-mysql >> "${FILELOG}" 2>&1
  rm -rf /etc/mysql /var/lib/mysql >> "${FILELOG}" 2>&1
  apt-get autoremove -y >> "${FILELOG}" 2>&1
  apt-get autoclean -y >> "${FILELOG}" 2>&1
  #printSuccess "Install debconf-utils"
  #sudo apt-get install -y debconf-utils >> "${FILELOG}" 2>&1

  printSuccess "Install Mysql Server 5.7"
  # install mysql and give password to installer
  export DEBIAN_FRONTEND="noninteractive"
  debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password password $PASSWORD"
  debconf-set-selections <<< "mysql-server-5.7 mysql-server/root_password_again password $PASSWORD"
  apt-get -y install mysql-server-5.7 mysql-client --fix-broken >> "${FILELOG}" 2>&1

  # replace config file my.cnf
  if [ -f "/vagrant/services/mysql/my57.cnf" ]; then
    printSuccess "Replacing the default configuration file for mysql if there"
    cp -rf /vagrant/services/mysql/my57.cnf /etc/mysql/my.cnf >> "${FILELOG}" 2>&1
  fi

  printSuccess "Start MySQL Server"
  service mysql restart >> "${FILELOG}" 2>&1

  printSuccess "Grant all privileges for root and ${USER} user"
  # grant all privileges on *.* to root@192.168.0.28 identified by 'password'
  mysql --user=root --password=${PASSWORD} mysql <<< "GRANT ALL ON *.* TO 'root'@'localhost'; FLUSH PRIVILEGES;" >> "${FILELOG}" 2>&1
  mysql --user=root --password=${PASSWORD} mysql <<< "CREATE USER 'root'@'%' IDENTIFIED BY '${PASSWORD}'; GRANT ALL ON *.* TO 'root'@'%'; FLUSH PRIVILEGES;" >> "${FILELOG}" 2>&1

  printSuccess "Restart MySQL Server"
  service mysql restart  >> "${FILELOG}" 2>&1
}
