#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.3.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh 

for count in 1 2 3 4 5; do
    echo "Thread Dump : $count"
    for i in `ps -ef | grep java | grep "SERVER=$SERVER_NAME " | awk '{print $2}'`;do
        date
    	echo "+kill -3 $i"
    	kill -3 $i
    done
    echo "done"
    echo "sleep 3 sec"
    sleep 3
done
	
