class base-lamp::ruby {

    $packageList = [
        "ruby",
        "rubygems"
        ]

    package { $packageList: }

    package{ 'bundler':
        provider => "gem",
        ensure => installed,
        require => Package['rubygems'],
    }

    package{ 'sass':
        provider => "gem",
        ensure => installed,
        require => Package['rubygems'],
    }
    package{ 'rb-inotify':
        provider => "gem",
        ensure => installed,
        require => Package['rubygems'],
    }
    package{ 'compass':
        provider => "gem",
        ensure => installed,
        require => Package['rubygems'],
    }
}