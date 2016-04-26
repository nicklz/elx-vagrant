#!/usr/bin/env bash



mongo mean-dev --eval "printjson(db.dropDatabase())"
mongo mean-prod --eval "printjson(db.dropDatabase())"
mongo mean-backup --eval "printjson(db.dropDatabase())"

cd ~/mongo_backups/ && mongorestore mean-prod-current



cd ~/www/elx-learning-module/sites/drupal && drush sql-cli < ~/mysql_backups/current/current.sql






