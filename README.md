#Vagrant Setup

##Pre-requisites
* Vagrant https://www.vagrantup.com/downloads.html
* Virtual Box https://www.virtualbox.org/wiki/Downloads

##Steps
* git clone git@github.com:nicklz/elx-vagrant.git vagrant
* mkdir docroot
* cp ~/.ssh/id_rsa vagrant/environment/puppet/modules/base-lamp/files/ssh/ (** ensure your ssh key has been added to all servers **)
* cd vagrant
* vagrant plugin install vagrant-hostsupdater
* vagrant up
* vagrant reload
* vagrant ssh
* ./scripts/setup.sh
* Visit in your browser: http://local.myelx.com
* Thats it!