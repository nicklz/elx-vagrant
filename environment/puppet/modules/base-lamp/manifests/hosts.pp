class base-lamp::hosts{

    file{'hosts':
            path => '/etc/hosts',
            ensure => present,
            source => "puppet:///modules/base-lamp/hosts/hosts",
            owner => root,
            group => root,
            mode => 0644;
    }


}