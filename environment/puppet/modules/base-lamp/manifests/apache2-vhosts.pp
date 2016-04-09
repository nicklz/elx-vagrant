class base-lamp::apache2-vhosts {

    file{'project.vhost':
            path => '/etc/apache2/sites-available/project',
            ensure => present,
            require => Package[apache2],
            source => "puppet:///modules/base-lamp/apache2/project.vhost",
            owner => root,
            group => root;
    }

    file{'/etc/apache2/sites-enabled/000-project':
            ensure => link,
            target => '/etc/apache2/sites-available/project',
            require => [Package['apache2'], File['project.vhost']],
            notify  => Service['apache2'],
            owner => root,
            group => root;
    }
}