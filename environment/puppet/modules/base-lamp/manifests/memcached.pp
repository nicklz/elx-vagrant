class base-lamp::memcached{
    package { 'memcached':
      ensure => 'latest'
    }

    service { 'memcached':
      ensure => running,
      enable => true,
      require => Package['memcached'],
    }

}