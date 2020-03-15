#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.3.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh $*

JBOSS_MODULEPATH="$JBOSS_HOME/modules/system/layers/base"

MODULES="org/jgroups"

for MODULE in $MODULES
do
    for JAR in `cd "$JBOSS_MODULEPATH/$MODULE/main/" && ls -1 *.jar`
    do
        CLASSPATH="$CLASSPATH:$JBOSS_MODULEPATH/$MODULE/main/$JAR"
    done
done

export CLASSPATH



PID=`ps -ef | grep java | grep "=JDG_GOSSIP_ROUTER " | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBoss JDG_GOSSIP_ROUTER - is already RUNNING..."
    exit;
fi

nohup java -classpath $CLASSPATH -Dname=JDG_GOSSIP_ROUTER org.jgroups.stack.GossipRouter -port 12001 >> gossip.out &