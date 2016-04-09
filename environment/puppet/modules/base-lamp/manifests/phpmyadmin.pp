class base-lamp::phpmyadmin {
    file{'phpmyadmin.vhost':
            path => '/etc/apache2/sites-available/phpmyadmin',
            ensure => present,
            require => Package[apache2],
            source => "puppet:///modules/base-lamp/phpmyadmin/phpmyadmin.vhost",
            owner => root,
            group => root;
    }
    
    
    file{'/etc/apache2/sites-enabled/000-phpmyadmin':
            ensure => link,
            target => '/etc/apache2/sites-available/phpmyadmin',
            require => [Package['apache2'], File['phpmyadmin.vhost']],
            notify  => Service['apache2'],
            owner => root,
            group => root;
    }
    
    file{'phpmyadmin':
            path => '/usr/share/phpmyadmin',
            ensure => present,
            recurse => true,
            source => "puppet:///modules/base-lamp/phpmyadmin/src",
            mode => 0644;

    }

}