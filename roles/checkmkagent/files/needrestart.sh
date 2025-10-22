#!/bin/bash
# check if server needs a reboot

### variables ###
service="needsreboot"
status=0
timewarn=1 # 1 second
timecrit=86400 # 1 days

### main ###

result=$(needrestart -p )
resultstatus=$( echo $result | cut -d ' ' -f1 )
if [ "$resultstatus" == "CRIT" ]
then
   installdate=$(grep " install " /var/log/dpkg.log | grep linux-image | tail -1 | cut -d ' ' -f1)
   timeuntilnow=$(( $( date +%s ) - $(date -d ${installdate} +%s ) ))
   #echo $timeuntilnow
   if [ $timeuntilnow -ge $timecrit ]
   then
      status=2
   elif [ $timeuntilnow -ge $timewarn ]
   then
      status=1
   fi
fi
statustext=$(echo $result | cut -d' ' -f3-)

echo "$status $service - $statustext"