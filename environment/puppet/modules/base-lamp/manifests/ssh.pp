class base-lamp::ssh{

    file{'ssh':
            path => '/home/vagrant/.ssh',
            ensure => present,
            recurse => true,
            source => "puppet:///modules/base-lamp/ssh",
            owner => vagrant,
            group => vagrant,
            mode => 0400;
    }

    exec{'sudo chmod 644 /home/vagrant/.ssh/known_hosts':

    }


}