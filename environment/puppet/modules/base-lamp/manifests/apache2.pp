class base-lamp::apache2{
    package{'apache2':
        ensure => installed
    }

    file { '/var/lock/apache2':
      ensure => directory,
      owner => 'vagrant',
      require => Package['apache2'],
    }
  
    service { 'apache2':
      ensure => running,
      enable => true,
      hasrestart => true,
      require => File['/var/lock/apache2'],
    }

    file{'project.crt':
            path => '/home/vagrant/project.crt',
            ensure => present,
            require => Package[apache2],
            source => "puppet:///modules/base-lamp/apache2/project.crt",
            notify  => Service['apache2'];

        'project.csr':
            path => '/home/vagrant/project.csr',
            ensure => present,
            require => Package[apache2],
            source => "puppet:///modules/base-lamp/apache2/project.csr",
            notify  => Service['apache2'];

        'project.key':
            path => '/home/vagrant/project.key',
            ensure => present,
            require => Package[apache2],
            source => "puppet:///modules/base-lamp/apache2/project.key",
            notify  => Service['apache2'];

        'apache.envvars':
            path => '/etc/apache2/envvars',
            ensure => present,
            require => Package[apache2],
            source => "puppet:///modules/base-lamp/apache2/envvars",
            owner => root,
            group => root,
            notify  => Service['apache2'],
            mode => 0644;
    }
    

}