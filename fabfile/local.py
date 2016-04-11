# import os
# from fabric.api import cd
from fabric.api import lcd
# from fabric.api import sudo
# from fabric.api import run
# from fabric.api import show
from fabric.api import get
# from fabric.api import put
from fabric.colors import green
#from fabric.colors import cyan
from fabric.colors import red
from fabric.api import local
from fabric.api import task
from fabric.api import roles
from fabric.api import execute
from fabric.api import settings
# import css as _css


@task
def setup():
    with settings(warn_only=True):
        # Install local database from staging server
        local("gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3");
        local("curl -sSL https://get.rvm.io | bash -s stable");
        local("echo '\n\n\n*** USE COMMAND: *** \n\n\n source /home/vagrant/.rvm/scripts/rvm && rvm install ruby-1.9.3-p551 && rvm use ruby-1.9.3-p551 \n\n\n'");
@task
def setup2():
    with settings(warn_only=True):
        local('echo "drop database myelx;" | mysql -uroot')
        local('echo "create database myelx;" | mysql -uroot')

        #nodejs



        local("curl -sL https://deb.nodesource.com/setup | sudo bash - && yes | sudo apt-get install nodejs");



        #mongodb
        local("sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10");
        local('echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list');
        local("sudo apt-get update");
        local("yes |  sudo apt-get install -y mongodb-org");
        local("yes |  sudo npm install -g bower");
        local("chown vagrant:vagrant /home/vagrant/.config/ -R");
        local("cd ~/www/elx-server && bower update");




@task
def watch():
    with settings(warn_only=True):
        # sass watch
        local("cd ~/www/sites/all/themes/myelx && bundle exec compass watch")


@task
def compile():
    with settings(warn_only=True):
        # sass compile
        local("cd ~/www/sites/all/themes/myelx && bundle exec compass compile")


@task
def sync():
    with settings(warn_only=True):
        # Sync local database from staging server
        local('mysql -u root -p drsusanloveresearch --password="" < /home/vagrant/www/dump.sql')
        #local("cd ~/www/sites/local.drsusanloveresearch.org && drush sql-sync @drsusanloveresearchllc.dev @drsusanloveresearchllc.local --create-db -y --source-dump=/tmp/tmp.sql --target-dump=/tmp/tmp.sql --no-cache")
        local("cd ~/www/sites/local.drsusanloveresearch.org && drush cc all")



@task
def synclime():
    with settings(warn_only=True):
        local('echo "drop database lime;" | mysql -uroot')
        local('echo "create database lime;" | mysql -uroot')