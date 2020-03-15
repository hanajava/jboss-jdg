#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.3.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh 

echo $JBOSS_HOME/bin/cli.sh --connect --controller=$CONTROLLER_IP:$CONTROLLER_PORT --command=:shutdown
# $JBOSS_HOME/bin/cli.sh --connect --controller=$CONTROLLER_IP:$CONTROLLER_PORT --command=:shutdown
$JBOSS_HOME/bin/cli.sh --connect --controller=$CONTROLLER_IP:$CONTROLLER_PORT
