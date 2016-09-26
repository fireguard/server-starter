#Parans
require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))
if !File.exist?("#{dir}/settings.yml")
  raise 'Configuration file not found! Please copy settings.example.yml to settings.yml and try again.'
end
settings = YAML::load_file("#{dir}/settings.yml")

Vagrant.require_version '>= 1.6.0'
Vagrant.configure(2) do |config|
  config.vm.hostname          = settings['vagrant']['host_name']
  config.vm.box               = settings['vagrant']['box_name']
  config.vm.box_url           = settings['vagrant']['box_url']
  config.vm.box_check_update  = settings['vagrant']['check_update']

  # Config Forwarders
  settings['forwarders'].each do |forwarder|
    config.vm.network "forwarded_port"	, guest: forwarder[0], host: forwarder[1]
  end

  # config.vm.network "private_network", ip: settings['vagrant']['private_ip']
	config.vm.network "private_network", type: "dhcp"

  # Config Mapping local folder
  if settings['vagrant']['nfs']
    config.vm.synced_folder "", "/vagrant",
      :nfs => true,
      :mount_options => ['nolock,vers=3,udp,noatime']

    config.vm.synced_folder settings['vagrant']['synced_folder'], "/home/vagrant/www",
      :nfs => true,
      :mount_options => ['nolock,vers=3,udp,noatime']

  else
    config.vm.synced_folder ".", "/vagrant",
      owner: "vagrant",
      group: "www-data",
      create: true,
      :mount_options => ["dmode=777","fmode=777"]

    config.vm.synced_folder settings['vagrant']['synced_folder'], "/home/vagrant/www",
      owner: "vagrant",
      group: "www-data",
      create: true,
      :mount_options => ["dmode=777","fmode=777"]
  end

  # Config Provider
  config.vm.provider "virtualbox" do |vb|
		vb.name		 = settings['vagrant']['host_name']
		vb.gui 	   = settings['vagrant']['gui']
		vb.memory  = settings['vagrant']['memory']
		vb.cpus    = settings['vagrant']['cpus']
	end

  # Fix Erro to print shell scripts
  config.vm.provision "shell", inline: "(grep -q 'mesg n' /root/.profile && sed -i '/mesg n/d' /root/.profile && echo '') || exit 0;"

  # Config Services
  settings['start'].each do |service|
    # puts "Service: #{service} -> #{[settings['vagrant']['log_file'], settings['vagrant']['host_name']].concat(settings['services'][service] ||= [])}"
    config.vm.provision "shell" do |s|
      s.path = "services/#{service}/start.sh"
      s.args = [
        settings['vagrant']['log_file'],
        settings['vagrant']['host_name']
      ].concat(settings['services'][service] ||= [])
    end
  end
end
