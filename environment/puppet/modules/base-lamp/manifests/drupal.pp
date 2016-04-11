class base-lamp::drupal {

    file{'local.myelx.com':
            path => '/home/vagrant/www/elx-learning-module/sites/local.myelx.com',
            ensure => present,
            recurse => true,
            source => "puppet:///modules/base-lamp/drupal/local.myelx.com",
            owner => vagrant,
            group => vagrant;
    }

}