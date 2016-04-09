class base-lamp::cleanup{
   file{'php.ini':
            path => '/etc/php.ini',
            ensure => present,
            source => "puppet:///modules/base-lamp/php/php.ini",
            owner => root,
            group => root,
            mode => 0644;
    }
    
    exec{'mkdir /etc/php5 & mkdir /etc/apache2/ & mv /etc/php.ini /etc/php5/apache2/php.ini':

    }
    
        
    file{'my.cnf':
            path => '/etc/mysql/my.cnf',
            ensure => present,
            source => "puppet:///modules/base-lamp/mysql/my.cnf",
            owner => root,
            group => root,
            mode => 0644;
    }



}