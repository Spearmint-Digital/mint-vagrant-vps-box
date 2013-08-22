# Puppet manifest for my PHP dev machine

class system-setup {
    #Set default path for Exec calls
    Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

    #Epel repo installation, keeping of local yum files, automatic updates disabled.
    class { 'yum':
    }
}

class dev-packages {
    #Development packages.
    $dev_packages = ['vim-enhanced','telnet','zip','unzip','git']
    package { $dev_packages: ensure => latest }
}

class firewall-setup {
    #Firewall (iptables) package and rules to allow ssh, http, https and dns.
    class iptables {
        package { "iptables":
            ensure => present
        }

        service { "iptables":
            require => Package["iptables"],
            hasstatus => true,
            status => "true",
            hasrestart => false,
        }

        file { "/etc/sysconfig/iptables":
            owner   => "root",
            group   => "root",
            mode    => 600,
            replace => true,
            ensure  => present,
            source  => "/vagrant/conf/iptables.txt",
            require => Package["iptables"],
            notify  => Service["iptables"],
        }
    }

    class { 'iptables': }
}

class apache-setup {
    #setup apache
    class { 'apache':
        require => Package["iptables"],
    }

    #setup vhost (can do multiple of these)
    apache::vhost { 'centos.local':
        priority        => '1',
        port            => '80',
        serveraliases   => ['www.centos.local',],
        docroot         => '/www',
        docroot_owner	=> 'vagrant',
        docroot_group	=> 'vagrant',
        logroot         => '/logs/httpd',
        options         => 'FollowSymLinks MultiViews',
    }
}

class mysql-setup {
    #setup mySQL with random password ( saved in /root/.my.cnf )
    class { "mysql":
        root_password => 'auto',          
    }

    #TODO change db and password on live server
    mysql::grant { 'wordpress':
        mysql_privileges => 'ALL',
        mysql_password => 'wordpress-vagrant',
        mysql_db => 'wordpress',
        mysql_user => 'wordpress',
        mysql_host => 'localhost',
    }
}

class php-setup {
    #setup php, modules and php.ini
    php::ini {
        '/etc/php.ini':
            display_errors	=> 'On',
            short_open_tag	=> 'Off',
            memory_limit	=> '256M',
            date_timezone	=> 'Australia/Adelaide'
    }

    include php::cli
    include php::mod_php5
    
    $php = [ 'fpm', 'pear', 'mysql', 'gd', 'tidy', 'pecl-apc']
    php::module { $php: 

    }
}

#include all the classes
include system-setup
include dev-packages
include firewall-setup
include apache-setup
include mysql-setup
include php-setup
