#!/usr/bin/env bash
echo "--------------------------------------------------------"
echo " Installation Script"
echo " Fireguard Soluções em Tecnologia Ltda"
echo " Version: 1.0.0"
echo " Author: Ronaldo Meneguite"
echo "--------------------------------------------------------"

source /vagrant/scripts/functions.sh

FILELOG=$1
HOSTNAME=$2
TIMEZONE=$3
DOMAIN_DEV=$4

# Configure timezone
printSuccess "Setting default system timezone"
timedatectl set-timezone ${TIMEZONE}
dpkg-reconfigure -f noninteractive tzdata >> "${FILELOG}" 2>&1

# Generate hosts file
printSuccess "Creating alias for localhost"
echo "127.0.0.1		localhost"   > /etc/hosts
echo "127.0.1.1		${HOSTNAME}" >> /etc/hosts
echo "127.0.0.1		${DOMAIN_DEV}" >> /etc/hosts

# Generate SSH Key
if [ -e "/home/ubuntu/.ssh/id_rsa" ]; then
  printSuccess "SSH keys exist"
else
  printSuccess "Generate SSH keys"
  mkdir -p /home/ubuntu/.ssh
  ssh-keygen -t rsa -N "" -f /home/ubuntu/.ssh/id_rsa >> "${FILELOG}" 2>&1
  chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
  chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa.pub
fi

# Update BashRC
if [ -f "/vagrant/services/bootstrap/.bashrc" ]; then
    printSuccess "Replacing the default configuration file for Bashrc if there"
    cp -rf /vagrant/services/bootstrap/.bashrc /home/ubuntu/.bashrc >> "${FILELOG}" 2>&1
fi

# Initial Update
if [ -f "/var/vagrant_initial_update" ]; then
  printSuccess "Initial update has already been made"
else
  printSuccess "Remove default apache install for ubuntu server"
  apt-get purge -y `dpkg -l | grep apache| awk '{print $2}' |tr "\n" " "` >> "${FILELOG}" 2>&1

  printSuccess "Running the update server packages"
  apt-get update >> "${FILELOG}" 2>&1
  apt-get upgrade -y >> "${FILELOG}" 2>&1
  touch /var/vagrant_initial_update
fi
