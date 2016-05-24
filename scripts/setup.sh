#!/usr/bin/env bash

#this was causing ssh errors
sudo locale-gen  en_US.UTF-8 
export LC_ALL="en_US.UTF-8" 
export LANG="en_US.UTF-8" 

#so we dont have to type yes

ssh-keyscan -H github.com >> ~/.ssh/known_hosts

ssh-keyscan -H keys.gnupg.net >> ~/.ssh/known_hosts

ssh-keyscan -H repo.mongodb.org >> ~/.ssh/known_hosts

ssh-keyscan -H raw.githubusercontent.com >> ~/.ssh/known_hosts

ssh-keyscan -H stagemyelx.cloudapp.net >> ~/.ssh/known_hosts
ssh-keyscan -p 50018 -H stagemyelx.cloudapp.net >> ~/.ssh/known_hosts
ssh-keyscan -p 62440 -H stagemyelx.cloudapp.net >> ~/.ssh/known_hosts
ssh-keyscan -p 49894 -H stagemyelx.cloudapp.net >> ~/.ssh/known_hosts



#TODO: this needs to be added to a config file
cd ~/www/ && git config --global user.email "nicholas.kuhn@spi.com"
cd ~/www/ && git config --global user.name "Nick Kuhn"
cd ~/www/ && git config --global core.editor "vim"

#set up git repos
rm -rf /home/vagrant/www/elx-interface
rm -rf /home/vagrant/www/elx-server
rm -rf /home/vagrant/www/elx-learning-module
rm -rf /home/vagrant/www/elx-newplayer

cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-interface.git
cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-server.git
cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-learning-module.git
cd ~/www/ && git clone git@github.com:MasterDoublePrime/elx-newplayer.git

#ruby - vagrant makes this hard but this should sort things out
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /home/vagrant/.rvm/scripts/rvm
rvm install ruby-1.9.3-p551 
rvm use ruby-1.9.3-p551 

#nodejs
curl -sL https://deb.nodesource.com/setup | sudo bash - && yes | sudo apt-get install nodejs

#mongodb
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
sudo apt-get update
yes | sudo apt-get install -y mongodb-org
sudo mkdir -p /data/db
sudo sed -i 's/\/var\/lib\/mongodb/\/data\/db/g' /etc/mongod.conf
#sudo mongod --port 27020 &
mongod &
sudo mkdir /data
sudo mkdir /data/mongo_backups
sudo chmod 777 /data/ -R
cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mongo.sh

#mysql
sudo mkdir /data/mysql_backups
sudo chmod 777 /data/mysql_backups
rm -rf ~/www/elx-learning-module/sites/default/settings.php && cp -rf ~/www/drupal/settings.php ~/www/elx-learning-module/sites/default/settings.php
cd ~/scripts/ && ./vagrant-sync-mysql.sh

#npn stuff - this version is currently the only one I found that works
sudo npm update npm -g
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
nvm install v0.10.44
nvm alias default v0.10.44

yes |  sudo npm install -g bower  gulp  grunt time-grunt karma  forever  node-gyp




~/scripts/finish.sh




#fix varnish ports (use 80) - this is special only to ubuntu 15 unfortunately
sudo sed -i 's/6081/80/g' /etc/default/varnish
sudo sed -i 's/6081/80/g' /etc/systemd/system/multi-user.target.wants/varnish.service
sudo cp /lib/systemd/system/varnish.service /etc/systemd/system/
sudo sed -i 's/6081/80/g' /etc/systemd/system/varnish.service

sudo systemctl daemon-reload
sudo systemctl restart varnish.service

#change apache to 8080
sudo sed -i 's/80/8080/g' /etc/apache2/ports.conf


sudo a2dissite 000-default.conf
sudo service apache2 restart
sudo service varnish restart


cd ~/www/elx-server && nohup node server.js &