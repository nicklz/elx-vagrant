class base-lamp::drush {
    package{ "drush":
        ensure => installed
    }
    
    
    file{'.drush':
            path => '/home/vagrant/.drush',
            ensure => present,
            recurse => true,
            source => "puppet:///modules/base-lamp/drush/.drush",
            owner => vagrant,
            group => vagrant;
    }
}