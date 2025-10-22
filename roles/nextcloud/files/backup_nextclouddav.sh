#!/bin/bash

BACKUPDIR=/backup/nextclouddav
DATE=`date '+%Y%m%d_%H_%M_%S'`
NEXTCLOUD_PATH=/var/www/nextcloud

if [ ! -d $BACKUPDIR ]
then
    mkdir $BACKUPDIR
fi

rm $BACKUPDIR/*

sudo -u www-data php ${NEXTCLOUD_PATH}/occ maintenance:mode --on

/backup/scripts/calcardbackup "${NEXTCLOUD_PATH}" -o $BACKUPDIR

sudo -u www-data php ${NEXTCLOUD_PATH}/occ maintenance:mode --off