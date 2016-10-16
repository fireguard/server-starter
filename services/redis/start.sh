#!/usr/bin/env bash

FILELOG=$1
VERSION=$3

source /vagrant/scripts/functions.sh

printHeader "Start Redis Server Service"

INSTALED=$( checkIsInstaled redis-server )
if [ "$INSTALED" == "false" ]; then

    printSuccess "Install Redis Server"
    apt-get install -y redis-server >> "${FILELOG}" 2>&1

    # replace config file my.cnf
    if [ -f "/vagrant/services/redis/redis.conf" ]; then
      printSuccess "Replacing the default configuration file for redis server if there"
      cp -rf /vagrant/services/redis/redis.conf /etc/redis/redis.conf >> "${FILELOG}" 2>&1

      printSuccess "Restart Redis Server"
      service redis-server restart >> "${FILELOG}" 2>&1
    fi
    
else
  printSuccess "Redis Server is installed"
fi
