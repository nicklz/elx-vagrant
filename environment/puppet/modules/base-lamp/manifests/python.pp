class base-lamp::python {

    $packageList = [
    'python2.7',
    'python-dev',
    'python-pip'
    ]

    package { $packageList: }

    exec{'sudo /usr/bin/pip install fabric':
        require => [Package['python-pip'], Package[python-dev], Package['python2.7']],
        unless => 'pip freeze | grep Fabric'
    }
    
    #package{ 'fabric':
    #    provider => "pip",
    #    ensure => installed,
    #    require => [Package['python-pip'], Package[python-dev], Package['python2.7']],
    #}
}