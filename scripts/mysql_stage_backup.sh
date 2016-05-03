#!/bin/bash


rm -rf  /data/backups/current/*

cd /var/www/html/sites/default/ && drush sql-dump | gzip > /data/backups/current/current.sql.gz
