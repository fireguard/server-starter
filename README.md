# Fireguard Vagrant Server

# Requirements

  - VirtualBox: https://www.virtualbox.org/wiki/Downloads (5.1.2)
  - Vagrant:	https://www.vagrantup.com/downloads.html  (1.8.5)

## Plugins
  - This package required to install this plugins
  ```
    vagrant plugin install vagrant-vbguest

    vagrant plugin install vagrant-winnfsd
  ```

## Install and Use

### Clone repository in local directory
```
  git clone https://github.com/fireguard/server-starter.git NAME_NEW_DIRECTORY
```
Ps.: You can download the zip file directly from github and extract it in the
local folder

### Set default parameters

Before you begin, set the parameters using the file "settings.yml" for that
use "setting.example.yml" file as a template.

**Special attention to these parameters:**
```
vagrant:
    ...
    host_name: "srv-fireguard"
    ...
    synced_folder: "./../../Projects" # Relative Path to Project
    ...
    memory: 2000  # 2 GB
    cpus: 2
    ...
services:
    bootstrap:
      ...
      - "fireguard.dev" # dev domain
    ...
    mysql:
      ...
      - "password" # Password for root
    git:
      ...
      - "Your Name"       # user name
      - "your@email.com"  # email
...
```
### Start the Virtual Machine

```
# This command start the virtual machine
# Inside the machine folder created
vagrant up

# If an error occurs when booting the machine run the following commands
vagrant reload
vagrant provision

```


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
