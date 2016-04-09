#Vagrant Setup

##Pre-requisites
* Vagrant https://www.vagrantup.com/downloads.html
* Virtual Box https://www.virtualbox.org/wiki/Downloads

##Steps
* git clone git@github.com:nicklz/drsusanloveresearch_vagrant.git vagrant
* cd vagrant
* vagrant plugin install vagrant-hostsupdater
* vagrant up
* vagrant ssh
* fab local.setup
* source /home/vagrant/.rvm/scripts/rvm && rvm install ruby-1.9.3-p551 && rvm use ruby-1.9.3-p551
* fab local.setup2
* Visit in your browser: http://local.drsusanloveresearch.org
* Thats it!