node default{
    Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin" }
    
    stage { first: before => Stage[main] }
    stage { last: require => Stage[main] }
    
    include base-lamp
    include base-lamp::apache2
    include base-lamp::apache2-modules
    include base-lamp::apache2-vhosts
    include base-lamp::python
    include base-lamp::ruby
    include base-lamp::vim
    include base-lamp::zend
    include base-lamp::php5
    include base-lamp::git
    include base-lamp::mysql5
    include base-lamp::ssh
    #include base-lamp::grunt
    include base-lamp::drush
    include base-lamp::drupal
    include base-lamp::memcached
    include base-lamp::sshpass
    include base-lamp::curl
    include base-lamp::rsync
    #include base-lamp::phpmyadmin
    include base-lamp::cleanup
    include base-lamp::configuration-vagrant
}