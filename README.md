# Mint Vagrant VPS Box (for PHP development)

## Installation

* Install vagrant using the installation instructions in the [Getting Started document](http://vagrantup.com/v1/docs/getting-started/index.html)
* Add a Centos 6.4 box using the [available official boxes](https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Boxes), for example: ```vagrant box add CentOS-6.4-x86_64 http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box``` (make sure it's named CentOS-6.4-x86_64)
* Clone this repository
* Install submodules with ```git submodule update --init```
* After running ```vagrant up``` the box is set up using Puppet
* You should now be able to access PHP unser http://localhost:8080 or http://192.168.33.10 in your web browser
* You can put files in /shared/www

## Installed components

* [apache](http://httpd.apache.org/) using puppet module (https://github.com/puppetlabs/puppetlabs-apache.git)
* [git](http://git-scm.com/)
* [iptables](http://wiki.centos.org/HowTos/Network/IPTables) using puppet module (https://github.com/puppetlabs/puppetlabs-firewall.git)
* [mySQL](http://dev.mysql.com/downloads/mysql/) using puppet module (https://github.com/example42/puppet-mysql)
* [php](http://php.net) using puppet module (https://github.com/thias/puppet-php.git)
* [vim] (http://www.vim.org/)
* [yum + epel repo] (https://fedoraproject.org/wiki/EPEL) using puppet module (https://github.com/example42/puppet-yum.git)

## Hints
####Startup speed
To speed up the startup process use ```$ vagrant up --no-provision``` 


##TODO
Install capistrano for use in php deployment, and railsless-deploy and capistrano-ext gems
