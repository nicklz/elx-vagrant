class base-lamp::capistrano{
    package { 'capistrano':
      ensure => 'latest'
    }

    service { 'capistrano':
      ensure => running,
      enable => true,
      require => Package['capistrano'],
    }

}