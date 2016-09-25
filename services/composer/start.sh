#!/usr/bin/env bash
source /vagrant/scripts/functions.sh

FILELOG=$1

printHeader "Start Composer Service"

if [ -f "/usr/local/bin/composer" ]; then
  printSuccess "Composer is installed"
else
  printSuccess "Install Composer"
	curl -s https://getcomposer.org/installer | php >> "${FILELOG}" 2>&1
	sudo mv composer.phar /usr/local/bin/composer >> "${FILELOG}" 2>&1
fi
