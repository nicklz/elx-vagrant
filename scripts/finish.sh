#!/usr/bin/env bash


sudo locale-gen  en_US.UTF-8 
export LC_ALL="en_US.UTF-8" 
export LANG="en_US.UTF-8" 

yes |  sudo npm install -g bower gulp  grunt time-grunt karma  forever node-gyp  mean-cli




#build / update the codebases
sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-server && bower update &&  npm install mean-cli && sudo ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-newplayer && bower update  &&  sudo  ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-interface && bower update &&  sudo  ./jenkins.sh

#wire everything up
mkdir /home/vagrant/www/elx-server/packages/custom/elx/public/assets

ln -s /home/vagrant/www/elx-interface/src/app /home/vagrant/www/elx-server/packages/custom/elx/public/assets/app
ln -s /home/vagrant/www/elx-interface/bower_components /home/vagrant/www/elx-server/packages/custom/elx/public/assets/bower_components 
ln -s /home/vagrant/www/elx-interface/src/fonts /home/vagrant/www/elx-server/packages/custom/elx/public/assets/fonts 
ln -s /home/vagrant/www/elx-server/dist/inject /home/vagrant/www/elx-server/packages/custom/elx/public/assets/inject 
ln -s /home/vagrant/www/elx-interface/locales /home/vagrant/www/elx-server/packages/custom/elx/public/assets/locales 
ln -s /home/vagrant/www/elx-interface/src/scripts /home/vagrant/www/elx-server/packages/custom/elx/public/assets/scripts 
ln -s /home/vagrant/www/elx-interface/dist/styles /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles 
ln -s /home/vagrant/www/elx-interface/src/app/theme/fonts/ /home/vagrant/www/elx-server/packages/custom/elx/public/assets/elx_fonts/ 
ln -s /home/vagrant/www/elx-interface/src/app/theme/fonts /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles/theme/fonts
ln -s /home/vagrant/www/elx-interface/src/app/theme/images /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles/theme/images 
ln -s /home/vagrant/www/elx-interface/src/index.html /home/vagrant/www/elx-server/packages/custom/elx/server/views/index.html 

sudo service apache2 restart
sudo service varnish restart
cd ~/www/elx-server node server.js