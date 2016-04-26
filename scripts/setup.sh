#!/usr/bin/env bash

#this was causing ssh errors
sudo locale-gen  en_US.UTF-8 
export LC_ALL="en_US.UTF-8" 
export LANG="en_US.UTF-8" 

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
sudo mongod --port 27020 &
mkdir /home/vagrant/mongo_backups
cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mongo.sh

#mysql
mkdir /home/vagrant/mysql_backups
rm -rf ~/www/elx-learning-module/sites/drupal && cp -rf ~/www/drupal ~/www/elx-learning-module/sites/
cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mysql.sh

#npn stuff - this version is currently the only one I found that works
sudo npm update npm -g
sudo curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
nvm install v0.10.44
nvm alias default v0.10.44

yes |  sudo npm install -g bower
yes |  sudo npm install -g gulp
yes |  sudo npm install -g grunt
yes |  sudo npm install -g time-grunt
yes |  sudo npm install -g karma
yes |  sudo npm install -g forever
yes |  sudo npm install -g node-gyp



#build / update the codebases
sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-server && bower update && npm install mean-cli && ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-newplayer && bower update &&  ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-interface && bower update && ./jenkins.sh

#wire everything up
ln -s /home/vagrant/www/elx-interface/src/app /home/vagrant/www/elx-server/packages/custom/elx/public/assets/app 
ln -s /home/vagrant/www/elx-interface/bower_components /home/vagrant/www/elx-server/packages/custom/elx/public/assets/bower_components 
ln -s /home/vagrant/www/elx-interface/dist/fonts /home/vagrant/www/elx-server/packages/custom/elx/public/assets/fonts 
ln -s /home/vagrant/www/elx-interface/dist/inject /home/vagrant/www/elx-server/packages/custom/elx/public/assets/inject 
ln -s /home/vagrant/www/elx-interface/locales /home/vagrant/www/elx-server/packages/custom/elx/public/assets/locales 
ln -s /home/vagrant/www/elx-interface/dist/scripts /home/vagrant/www/elx-server/packages/custom/elx/public/assets/scripts 
ln -s /home/vagrant/www/elx-interface/dist/styles /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles 
ln -s /home/vagrant/www/elx-interface/src/app/theme/fonts /home/vagrant/www/elx-server/packages/custom/elx/public/assets/fonts/ 
ln -s /home/vagrant/www/elx-interface/src/app/theme/fonts /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles/theme/fonts 
ln -s /home/vagrant/www/elx-interface/src/app/theme/images /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles/theme/images 
ln -s /home/vagrant/www/elx-interface/dist/index.html /home/vagrant/www/elx-server/packages/custom/elx/server/views/index.html 

#start everything up

sudo sed -i 's/6081/80/g' /etc/default/varnish
sudo sed -i 's/80/8080/g' /etc/apache2/ports.conf
sudo service apache2 restart
sudo service varnish restart

cd ~/www/elx-server node server.js