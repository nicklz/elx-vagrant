class base-lamp::php5{
    $phpPackageList = [
        "php5",
        #"php5-mysql",
        "php5-mysqlnd",
        "php5-gd",
        "php5-curl",
        "php5-xdebug",
        "php5-memcache",
        "php-pear",
        "php5-xmlrpc",
        "php5-mcrypt",
        "libapache2-mod-php5",
        "phpunit"]

    package { $phpPackageList:
        require => [Package['apache2'], Package['mysql-server']],
        notify => Service['apache2']
    }
}