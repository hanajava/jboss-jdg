#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.3.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh 

echo "======================================================="
echo " JMX URL : service:jmx:remoting-jmx://$MGMT_ADDR:$CONTROLLER_PORT"
echo "======================================================="
$JBOSS_HOME/bin/jconsole.sh
