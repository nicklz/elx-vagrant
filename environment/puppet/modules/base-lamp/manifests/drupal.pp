class base-lamp::drupal {

    file{'drupal':
            path => '/home/vagrant/www/drupal',
            ensure => present,
            recurse => true,
            source => "puppet:///modules/base-lamp/drupal/drupal",
            owner => vagrant,
            group => vagrant;
    }

}