# Fireguard Vagrant Server

# Requirements

  - VirtualBox: https://www.virtualbox.org/wiki/Downloads (5.0.16)
  - Vagrant:	https://www.vagrantup.com/downloads.html  (1.8.1)

## Plugins
  - For OSX and Linux is recommended to install this plugins

  ```
  vagrant plugin install vagrant-bindfs
  vagrant plugin install vagrant-triggers # redirect ports
  ```
  - For Windows is recommended to install this plugins
  ```
    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-winnfsd
  ```

## Install and Use

Before you begin, set the parameters using the file "settings.yml" for that use
"setting.example.yml" file as a template.



# Documentation for Reference

## Vagrant

  - **Start or resume your server**
  ```
  vagrant up
  ```

  - **Shutdown your server**
  ```
  vagrant halt
  ```

  - **SSH into your server**
  ```
  vagrant ssh
  ```

  - Add virtual box in system - **This process download the full OS image (500MB)**
  ```
  vagrant box add ubuntu/trusty64
  ```

  - List Box Available in the System
  ```
  vagrant box list
  ```

  - Pause your server
  ```
  vagrant suspend
  ```

  - Execute provision Instalation
  ```
  vagrant provision
  ```

  - Delete your server
  ```
  vagrant destroy
  ```

  - Reconfigure server with the new configuration file
  ```
  vagrant reload
  ```
  
  - Remove box
  ```
  vagrant box remove ubuntu/xenial64 --box-version 20160627.0.0
  ```


## Utils commands

  - Create Swap File
  ```
    sudo dd if=/dev/zero of=/swapfile bs=1G count=4
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
  ```

  - Check Free Memory
  ```
    free -m
  ```

  - Enable/Disable xdebug
  ```
  sudo php5enmod xdebug  # enable
  sudo php5dismod xdebug # disable
  sudo service apache2 restart or sudo service nginx restart
  ```

## Util Links

  - Vagrant Documentation: https://docs.vagrantup.com/v2/
  - Box for Download: https://atlas.hashicorp.com/boxes/search
