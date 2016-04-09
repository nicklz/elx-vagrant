class base-lamp::grunt {

    package { 'curl':
        ensure => installed,
    }
    
    package { 'python-software-properties':
      ensure => present,
      require => Exec['apt-get update'],
    }
  
    package { 'ruby1.9.3':
      ensure => present,
      require => Exec['apt-get update'],
    }
  
    # Get node
    exec { 'add node repo':
      command => 'apt-add-repository ppa:chris-lea/node.js && apt-get update',
      require => Package['python-software-properties'],
    }
  
    package { 'nodejs': 
      ensure => latest,
      require => [Exec['apt-get update'], Exec['add node repo']],
    }
  
  
    # install npm
    exec { 'npm':
      command => 'curl https://www.npmjs.org/install.sh | /bin/sh',
      environment => 'clean=yes',
    }
  
    # install sass
    exec { 'gem install sass': 
      command => 'gem install sass',
      require => Package['ruby1.9.3'],
    }
  
    # create symlink to stop node-modules foler breaking
    exec { 'node-modules symlink': 
      command => '/bin/rm -rfv /usr/local/node_modules && /bin/rm -rfv /vagrant/node_modules && /bin/mkdir /usr/local/node_modules && /bin/ln -sf /usr/local/node_modules /vagrant/node_modules ',
    }
  
    # finally install grunt
    exec { 'npm install -g grunt-cli bower':,
      command => 'npm install -g grunt-cli bower',
      require => Exec['npm'],
    }
  
    exec { 'npm-packages':,
      command => 'npm install',
      require => [Exec['npm install -g grunt-cli bower'], Exec['node-modules symlink']],
      cwd => '/vagrant',
    }
    
}