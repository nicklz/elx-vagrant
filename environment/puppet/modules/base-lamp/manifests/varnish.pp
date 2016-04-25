class base-lamp::varnish {
    package{ "varnish":
        ensure => installed
    }


    file{'default.vcl':
            path => '/etc/varnish/default.vcl',
            ensure => present,
            source => "puppet:///modules/base-lamp/varnish/default.vcl",
            owner => root,
            group => root,
            mode => 0644;
    }


    file{'varnish':
            path => '/etc/default/varnish',
            ensure => present,
            source => "puppet:///modules/base-lamp/varnish/varnish",
            owner => root,
            group => root,
            mode => 0644;
    }
}