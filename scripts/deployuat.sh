#!/usr/bin/env bash



sudo locale-gen  en_US.UTF-8 
export LC_ALL="en_US.UTF-8" 
export LANG="en_US.UTF-8" 

rsync -rvzLtm --delete-excluded --filter="P /packages/custom/elx/public/assets/badge_icons/" --filter="P /packages/custom/elx/public/assets/ctools/" --filter="P /packages/custom/elx/public/assets/elx_bulk/" --filter="P /packages/custom/elx/public/assets/feeds/" --filter="P /packages/custom/elx/public/assets/js/" --filter="P /packages/custom/elx/public/assets/languages/" --filter="P /packages/custom/elx/public/assets/private/" --filter="P /packages/custom/elx/public/assets/styles/*/" --filter="P /packages/custom/elx/public/assets/videos/" --filter="P /packages/custom/elx/public/assets/*.mp4" --filter="P /packages/custom/elx/public/assets/*.jpg" --filter="P /packages/custom/elx/public/assets/*.gif" --filter="P /packages/custom/elx/public/assets/*.pdf" --filter="P /packages/custom/elx/public/assets/*.png" --filter="P /packages/custom/elx/public/assets/*.JPG" --filter="P /packages/custom/elx/public/assets/*.PDF" --filter="P /packages/custom/elx/public/assets/*.ico" --filter="P /packages/custom/elx/public/assets/*.mov" --filter="P /packages/custom/elx/public/assets/*.jpeg" --filter="P /packages/custom/elx/public/assets/*.csv" --filter="P /packages/custom/elx/public/assets/*.tgz" --exclude=.DS_Store --exclude=/.git/ --exclude=/nbproject/  -e 'ssh -p 49894'  /home/vagrant/www/elx-server/ myelxadmin@uatmyelx.cloudapp.net:/data/www/

