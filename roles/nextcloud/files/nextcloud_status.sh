#!/bin/bash

#basepath of Nextcloud's occ executable
BASEPATH="/var/www/nextcloud"

sudo -u www-data php $BASEPATH/occ update:check | grep available > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "1 \"NextCloud\" - NextCloud Core needs updating"
elif [ $? -eq 1 ]; then
    echo "0 \"NextCloud\" - NextCloud all up to date"
fi

APPRESULT=$(sudo -u www-data php $BASEPATH/occ app:update --showonly)
if [[ "$APPRESULT" == *"up-to-date"* ]]; then
    echo "0 \"NextCloud Apps\" - NextCloud Apps all up to date"
else
    UPDATECOUNT=$(echo "$APPRESULT" | wc -l)
    echo "1 \"NextCloud Apps\" - $UPDATECOUNT NextCloud Apps require updates"
fi