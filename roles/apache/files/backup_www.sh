#! /bin/bash

BACKUPDIR=/backup/www
WWWWDIR="/var/www"
DATE=`date '+%Y%m%d_%H:%M:%S'`

if [ ! -d $BACKUPDIR ]
then
    mkdir $BACKUPDIR
fi
cd $BACKUPDIR

rm $BACKUPDIR/*

cd $WWWWDIR
for dir in $(ls) 
do
  if [ "$dir" != "html" ]
  then
    tar -czvf ${BACKUPDIR}/${dir}_${DATE}.tar.gz $dir 
  fi
done