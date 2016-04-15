#!/bin/bash


MONGO_IP="192.168.1.12"

MONGO_BACKUP_DIR='/home/myelxadmin/mongo_backups'

ssh $MONGO_IP 'cd /tmp && mongodump -o mean-prod'

ssh $MONGO_IP "mv /tmp/mean-prod ${MONGO_BACKUP_DIR}/mean-prod-current"

ssh $MONGO_IP "tar -zcvf ${MONGO_BACKUP_DIR}/mean-prod-current.tar.gz ${MONGO_BACKUP_DIR}/mean-prod-current"

ssh $MONGO_IP "rm -rf ${MONGO_BACKUP_DIR}/mean-prod-current"

ssh $MONGO_IP "rsync -a ${MONGO_BACKUP_DIR}/mean-prod-current.tar.gz myelxadmin@192.168.1.11:${MONGO_BACKUP_DIR}/mean-prod-current.tar.gz"
