#!/usr/bin/env bash

sudo mongod &
sudo service apache2 restart
sudo service varnish restart



cd ~/www/elx-server && nohup node server.js &