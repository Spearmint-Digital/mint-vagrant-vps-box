# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "CentOS-6.4-x86_64"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "192.168.33.10"

  # Hostname
  config.vm.host_name = "vagrant.development.com"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080
  config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.share_folder "s-www", 	"/www",		"./shared/www", 	:extra => 'dmode=777,fmode=777'
  config.vm.share_folder "s-logs", 	"/logs",	"./shared/logs",	:extra => 'dmode=777,fmode=777'
  config.vm.share_folder "s-database", 	"/database",	"./shared/database",	:extra => 'dmode=777,fmode=777'

  # This shell provisioner installs librarian-puppet and runs it to install
  # puppet modules. After that it just runs puppet
  config.vm.provision :shell, :path => "puppet/shell/bootstrap.sh"
    
  # This runs the puppet provisioner, note modules are entirely handled by librarian-puppet
  config.vm.provision :puppet do |puppet|
       puppet.manifests_path = "puppet/manifests"
  #     puppet.module_path = "puppet/modules"
       puppet.options  = ['--verbose']
       puppet.options = "--hiera_config /vagrant/puppet/hiera.yaml"
  end

end
