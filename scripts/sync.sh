#!/usr/bin/env bash



sudo locale-gen  en_US.UTF-8 
export LC_ALL="en_US.UTF-8" 
export LANG="en_US.UTF-8" 

cd ~/www/elx-server/packages/custom/elx/tools/ && ./vagrant-sync-mongo.sh
cd ~/scripts/ && ./vagrant-sync-mysql.sh
