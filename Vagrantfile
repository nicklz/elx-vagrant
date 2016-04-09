# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  host = RbConfig::CONFIG['host_os']
	config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  vm_config_path = File.expand_path(File.dirname(__FILE__)) + "/environment/config.json"
  vm_config = JSON.parse(File.read(vm_config_path))


  config.vm.box = vm_config["name"]
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  config.vm.box_url = vm_config["box_url"]


  config.vm.network :forwarded_port, guest: vm_config["ports"]["http_guest_varnish"],
    host: vm_config["ports"]["http_host_varnish"]
  config.vm.network :forwarded_port, guest: vm_config["ports"]["https_guest"],
    host: vm_config["ports"]["https_host"]
  config.vm.network :forwarded_port, guest: vm_config["ports"]["http_guest_apache"],
    host: vm_config["ports"]["http_host_apache"]

  config.vm.network :private_network, ip: vm_config["ip"]

  config.hostsupdater.remove_on_suspend = true
  config.vm.hostname = vm_config["hostname"]

  if defined? VagrantPlugins::HostsUpdater
    # Capture the paths to all hostname
    if !vm_config['aliases'].empty?
      config.hostsupdater.aliases = vm_config['aliases'].values
    end
  end

  if vm_config["nfs"] == true
    # Set no_root_squash to prevent NFS permissions errors on Linux during
    # provisioning, and maproot=0:0 to correctly map the guest root user.
    if (/darwin/ =~ host) != nil
      config.vm.synced_folder vm_config["synced_folder"]["host_path"],
        vm_config["synced_folder"]["guest_path"],
        type: "nfs", :bsd__nfs_options => ["maproot=0:0"]
      config.vm.synced_folder vm_config["synced_scripts"]["host_path"],
        vm_config["synced_scripts"]["guest_path"],
        type: "nfs", :bsd__nfs_options => ["maproot=0:0"]
    else
      config.vm.synced_folder vm_config["synced_folder"]["host_path"],
        vm_config["synced_folder"]["guest_path"],
        type: "nfs", :linux__nfs_options => ["no_root_squash"]
      config.vm.synced_folder vm_config["synced_scripts"]["host_path"],
        vm_config["synced_scripts"]["guest_path"],
        type: "nfs", :linux__nfs_options => ["no_root_squash"]
    end
  else
    config.vm.synced_folder vm_config["synced_folder"]["host_path"],
      vm_config["synced_folder"]["guest_path"]
    config.vm.synced_folder vm_config["synced_scripts"]["host_path"],
      vm_config["synced_scripts"]["guest_path"]
  end

  #config.vm.share_folder "www", "/home/vagrant/www", "../"
  #config.vm.share_folder "www/application/views/scripts/partials", "/home/vagrant/www/application/views/scripts/partials", "../application/views/scripts/linkedpartials/partials"

  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    vb.gui = false
    vb.name = vm_config['vm_name']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 2
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 2
    else # windows
      cpus = vm_config["cpus"]
      mem = vm_config["mem"]
    end

    vb.customize ["modifyvm", :id, "--memory", mem]
    vb.customize ["modifyvm", :id, "--cpus", cpus]
  end

  config.vm.provision :puppet, :options => "--no-report" do |puppet|
    puppet.manifests_path = "environment/puppet"
    puppet.manifest_file  = "main.pp"
    puppet.module_path    = "environment/puppet/modules"
  end
end
