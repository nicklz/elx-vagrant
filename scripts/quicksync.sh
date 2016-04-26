#!/usr/bin/env bash


mongo mean-dev --eval "printjson(db.dropDatabase())"
mongo mean-prod --eval "printjson(db.dropDatabase())"
mongo mean-backup --eval "printjson(db.dropDatabase())"

cd /home/vagrant/mongo_backups/ && mongorestore mean-prod-current





