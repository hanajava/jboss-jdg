#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.3.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

DATE=`date +%Y%m%d%H%M%S`

. ./env.sh

PID=`ps -ef | grep java | grep "=$SERVER_NAME " | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBoss SERVER - $SERVER_NAME is already RUNNING..."
    exit;
fi

UNAME=`id -u -n`
if [ e$UNAME != "e$JBOSS_USER" ]
then
    echo "Use $JBOSS_USER account to start JBoss SERVER - $SERVER_NAME..."
    exit;
fi

echo $JAVA_OPTS

if [ ! -d "$JBOSS_LOG_DIR/nohup" ];
then
    mkdir -p $JBOSS_LOG_DIR/nohup
fi  

if [ ! -d "$JBOSS_LOG_DIR/gclog" ];
then
    mkdir -p $JBOSS_LOG_DIR/gclog
fi  

if [ ! -d "$JBOSS_LOG_DIR/heapdump" ];
then
    mkdir -p $JBOSS_LOG_DIR/heapdump
fi  

mv $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out.$DATE

rm -rf tmp/*

export JAVA_OPTS="$AGENT_OPTS $JAVA_OPTS"

nohup $JBOSS_HOME/bin/clustered.sh -DSERVER=$SERVER_NAME -P=$DOMAIN_BASE/$SERVER_NAME/env.properties -c $CONFIG_FILE >> $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out 2>&1 &

echo "Starting $NODE_NAME "
until [ "`curl --silent -o --show-error --connect-timeout 1 -w "%{http_code}\n" http://$CONTROLLER_IP:$CONSOLE_PORT | egrep '200|301|302|500'`" != "" ];
do
    echo -ne "."
    sleep 1
done
echo -ne " Success"

PID=`ps -ef | grep java | grep jboss | grep "$NODE_NAME " | awk '{print $2}'`
echo " +$PID"

if [ e$1 = "enotail" ]
then
    echo "Starting... $SERVER_NAME"
    exit;
fi

#tail -f $JBOSS_LOG_DIR/nohup/$SERVER_NAME.out
