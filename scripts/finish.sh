#!/usr/bin/env bash

#build / update the codebases

sudo chmod 777 -R /usr/lib/node_modules

npm cache clean

#no bin links seems to fix an error for windows.. it needs to be ran a couple times too
sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-server && bower update &&  npm install karma sshpk mean-cli http-signature meanio --no-bin-links && npm install --no-bin-links&& npm install --no-bin-links

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-interface && bower update && npm install   jasmine-core karma && ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-interface && rm -rf bower_components && gulp --jenkins

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-newplayer && bower update &&  ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-interface && bower update

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-server && ./jenkins.sh && rm node_modules/meanio -rf && npm install



#wire everything up
rm -rf /home/vagrant/www/elx-server/packages/custom/elx/public/assets 
mkdir /home/vagrant/www/elx-server/packages/custom/elx/public/assets
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
