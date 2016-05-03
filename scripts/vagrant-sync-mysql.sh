#!/usr/bin/env bash


echo BACKUP STAGE MYSQL
ssh  myelxadmin@stagemyelx.cloudapp.net '/data/backups/mysql_stage_backup.sh'

echo DROP LOCAL DATABASE

echo "drop database drupal;" | mysql -uroot
echo "create database drupal;" | mysql -uroot

rm -rf /data/mysql_backups/*

rsync -rvz --progress --remove-sent-files myelxadmin@stagemyelx.cloudapp.net:/data/backups/current /data/mysql_backups

cd /data/mysql_backups/current && gunzip current.sql.gz
cd ~/www/elx-learning-module/sites/drupal && drush sql-cli < /data/mysql_backups/current/current.sql






