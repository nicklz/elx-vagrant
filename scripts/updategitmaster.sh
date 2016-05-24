#!/usr/bin/env bash

#this was causing ssh errors
sudo locale-gen  en_US.UTF-8 
export LC_ALL="en_US.UTF-8" 
export LANG="en_US.UTF-8" 


cd ~/www/ && git checkout elx-interface && git pull origin master
cd ~/www/ && git checkout elx-learning-module && git pull origin master
cd ~/www/ && git checkout elx-newplayer && git pull origin master
cd ~/www/ && git checkout elx-server && git pull origin master
