#!/usr/bin/env bash


sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-server && bower update && ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-interface && bower update && ./jenkins.sh

sudo chown vagrant:vagrant /home/vagrant/.config/ -R
cd ~/www/elx-newplayer && bower update && ./jenkins.sh


#wiring stuff up
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/app /home/vagrant/www/elx-interface/src/app
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/bower_components /home/vagrant/www/elx-interface/bower_components
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/fonts /home/vagrant/www/elx-interface/dist/fonts
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/inject /home/vagrant/www/elx-interface/dist/inject
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/locales /home/vagrant/www/elx-interface/locales
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/scripts /home/vagrant/www/elx-interface/dist/scripts
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles /home/vagrant/www/elx-interface/dist/styles
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/fonts/ /home/vagrant/www/elx-interface/src/app/theme/fonts/
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles/theme/fonts /home/vagrant/www/elx-interface/src/app/theme/fonts
ln -s /home/vagrant/www/elx-server/packages/custom/elx/public/assets/styles/theme/images /home/vagrant/www/elx-interface/src/app/theme/images
ln -s /home/vagrant/www/elx-server/packages/custom/elx/server/views/index.html /home/vagrant/www/elx-interface/dist/index.html
