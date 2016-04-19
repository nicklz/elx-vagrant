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
        #TODO: this is a bug and needs to be fixed
        local('sudo locale-gen  en_US.UTF-8 ')
        local('export LC_ALL="en_US.UTF-8" ')
        local('export LANG="en_US.UTF-8" ')

        #TODO: this needs to be added to a config file
        local('cd ~/www/ && git config --global user.email "nicholas.kuhn@spi.com"')
        local('cd ~/www/ && git config --global user.name "Nick Kuhn"')
        local('cd ~/www/ && git config --global core.editor "vim"')

        #set up repos
        local("cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-interface.git");
        local("cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-server.git");
        local("cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-learning-module.git");
        local("cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-newplayer.git");

        local("gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3");
        local("curl -sSL https://get.rvm.io | bash -s stable");
        #TODO: need to figure out source command or maybe not use fabric
        local("echo '\n\n\n*** USE COMMAND: *** \n\n\n source /home/vagrant/.rvm/scripts/rvm && rvm install ruby-1.9.3-p551 && rvm use ruby-1.9.3-p551 && sudo locale-gen  en_US.UTF-8 && export LC_ALL=\"en_US.UTF-8\" export LANG=\"en_US.UTF-8\"  \n\n\n'");
@task
def setup2():
    with settings(warn_only=True):
        #nodejs
        local("curl -sL https://deb.nodesource.com/setup | sudo bash - && yes | sudo apt-get install nodejs");



        #mongodb
        local("sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10");
        local('echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list');
        local("sudo apt-get update");
        local("yes |  sudo apt-get install -y mongodb-org");
        local("sudo mkdir -p /data/db");
        local("sudo mongod --port 27020 &");
        local("mkdir /home/vagrant/mongo_backups");
        local("cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mongo.sh");

        #mysql
        local("mkdir /home/vagrant/mysql_backups");
        local("rm -rf ~/www/elx-learning-module/sites/drupal && cp -rf ~/www/drupal ~/www/elx-learning-module/sites/")
        local("cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mysql.sh");


        #npn stuff
        local("yes |  sudo npm install -g bower");
        local("sudo chown vagrant:vagrant /home/vagrant/.config/ -R");
        local("cd ~/www/elx-server && bower update");
        local("yes |  sudo npm install -g gulp");
        local("yes |  sudo npm install -g grunt");
        local("yes |  sudo npm install -g time-grunt");

        local("sudo chown vagrant:vagrant /home/vagrant/.config/ -R");
        local("cd ~/www/elx-interface && bower update");

        local("cd ~/www/elx-newplayer && bower update");





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
        local("cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mongo.sh");
        local("cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mysql.sh");


