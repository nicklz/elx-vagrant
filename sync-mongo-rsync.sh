#!/usr/bin/env bash

echo BACKUP STAGE MONGODB
ssh -p 49894 myelxadmin@stagemyelx.cloudapp.net './mongo_backup_rsync.sh'

echo DROP LOCAL DATABASE

mongo mean-dev --eval "printjson(db.dropDatabase())"
mongo mean-prod --eval "printjson(db.dropDatabase())"
mongo mean-backup --eval "printjson(db.dropDatabase())"


rsync -rvz -e 'ssh -p 49894' --progress --remove-sent-files myelxadmin@stagemyelx.cloudapp.net:/home/myelxadmin/mongo_backups/ /home/vagrant/mongo_backups/


tar -zxvf /home/vagrant/mongo_backups/mean-prod-current.tar.gz





