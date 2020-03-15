#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.3.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


DATE=`date +%Y%m%d_%H%M%S`

##### JBOSS Directory Setup #####
export JBOSS_HOME=/svc/jdg/jboss-datagrid-6.3.0-server
export DOMAIN_BASE=/svc/jdg/domains
export SERVER_NAME=hanaDG11
export JBOSS_LOG_DIR=$DOMAIN_BASE/$SERVER_NAME/logs

if [ e$JBOSS_LOG_DIR = "e" ]
then
export JBOSS_LOG_DIR="$DOMAIN_BASE/$SERVER_NAME/logs"
fi

if [ e$JBOSS_LOG_DIR != "e" ]
then
export JBOSS_LOG_DIR="$DOMAIN_BASE/$SERVER_NAME/logs"
fi


##### Configration File #####
export CONFIG_FILE=clustered.xml

export HOST_NAME=was01
export NODE_NAME=$SERVER_NAME

export PORT_OFFSET=100


export JBOSS_USER=jboss

##### Bind Address #####
   
export BIND_ADDR=192.168.110.141

#export MULTICAST_ADDR=230.21.1.1
export MULTICAST_ADDR=224.0.0.111
export MULTICAST_PORT=55200
#export MODCLUSTER_MULTICAST_ADDR=224.21.1.105
export MODCLUSTER_MULTICAST_ADDR=224.0.0.111

export MGMT_ADDR=192.168.110.141

export CONTROLLER_IP=$MGMT_ADDR
let CONTROLLER_PORT=9999+$PORT_OFFSET
export CONTROLLER_PORT

let CONSOLE_PORT=9990+$PORT_OFFSET
export CONSOLE_PORT

export LAUNCH_JBOSS_IN_BACKGROUND=true

##### JBoss System module and User module directory #####
export JBOSS_MODULEPATH=$JBOSS_HOME/modules

##### KHAN [agent] #####
#export AGENT_OPTS="-javaagent:/svc/jdg/hana/domains/khan-agent/khan-agent-1.0.0.jar"
#export AGENT_OPTS="$AGENT_OPTS -Dkhan.config.file=khan-agent-hanaDG11.conf"

# JVM Options : Server
export JAVA_OPTS="-server $JAVA_OPTS"

# JVM Options : Memory 
export JAVA_OPTS=" $JAVA_OPTS -Xms512m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=256m -Xss256k"

export JAVA_OPTS=" $JAVA_OPTS -XX:+PrintGCTimeStamps "
export JAVA_OPTS=" $JAVA_OPTS -XX:+PrintGCDetails "
export JAVA_OPTS=" $JAVA_OPTS -Xloggc:$JBOSS_LOG_DIR/gclog/gc_$DATE.log "

export JAVA_OPTS=" $JAVA_OPTS -XX:+UseParallelGC "
export JAVA_OPTS=" $JAVA_OPTS -XX:+UseParallelOldGC "

#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseConcMarkSweepGC "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+ExplicitGCInvokesConcurrent "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseParNewGC "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+CMSParallelRemarkEnabled "
#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseCMSCompactAtFullCollection "

#export JAVA_OPTS=" $JAVA_OPTS -XX:+UseG1GC "
#export JAVA_OPTS=" $JAVA_OPTS -XX:MaxGCPauseMillis=200 "

export JAVA_OPTS=" $JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError "
export JAVA_OPTS=" $JAVA_OPTS -XX:HeapDumpPath=$JBOSS_LOG_DIR/heapdump "


# Linux Large Page Setting
#export JAVA_OPTS=" $JAVA_OPTS  -XX:+UseLargePages "
#export JAVA_OPTS=" $JAVA_OPTS  -XX:LargePageSizeInBytes=2m "

#export JAVA_OPTS=" $JAVA_OPTS -verbose:gc"
export JAVA_OPTS=" $JAVA_OPTS -Djava.net.preferIPv4Stack=true"
export JAVA_OPTS=" $JAVA_OPTS -Dorg.jboss.resolver.warning=true"
export JAVA_OPTS=" $JAVA_OPTS -Dsun.rmi.dgc.client.gcInterval=0x7FFFFFFFFFFFFFFE"
export JAVA_OPTS=" $JAVA_OPTS -Dsun.rmi.dgc.server.gcInterval=0x7FFFFFFFFFFFFFFE"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.modules.system.pkgs=org.jboss.byteman,com.opennaru.khan.agent"
export JAVA_OPTS=" $JAVA_OPTS -Djava.awt.headless=true"

#for darwin
export JBOSS_BASE_DIR="$DOMAIN_BASE_DIR"

export JAVA_OPTS=" $JAVA_OPTS -Djboss.server.base.dir=$DOMAIN_BASE/$SERVER_NAME"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.socket.binding.port-offset=$PORT_OFFSET"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.node.name=$NODE_NAME"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.bind.address.management=$MGMT_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.bind.address=$BIND_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.default.multicast.address=$MULTICAST_ADDR"
export JAVA_OPTS=" $JAVA_OPTS -Djboss.modcluster.multicast.address=$MODCLUSTER_MULTICAST_ADDR"

export JAVA_OPTS=" $JAVA_OPTS -Dbalancer=balancer_hana"
export JAVA_OPTS=" $JAVA_OPTS -DbalancerGroup=G_hana"

export JAVA_OPTS=" $JAVA_OPTS -Djboss.server.log.dir=$JBOSS_LOG_DIR"

# jgroups stack
# udp, tcp, tcp-fileping, tcp-gossip
export JAVA_OPTS=" $JAVA_OPTS -Djboss.default.jgroups.stack=udp "
export JAVA_OPTS=" $JAVA_OPTS -Djgroups.tcpping.initial_hosts=192.168.110.141[7700],192.168.110.141[7800],192.168.110.142[7700],192.168.110.142[7800], "
export JAVA_OPTS=" $JAVA_OPTS -Djgroups.fileping.location=/share/data/fileping "
export JAVA_OPTS=" $JAVA_OPTS -Djgroups.tcpgossip.hosts=192.168.110.141[12001],192.168.110.142[12001] " 

# Use log4j in application
export JAVA_OPTS=" $JAVA_OPTS -Dorg.jboss.as.logging.per-deployment=false "

# JDG Settings
export JAVA_OPTS=" $JAVA_OPTS -Dinfinispan.arrays.debug=true "
export JAVA_OPTS=" $JAVA_OPTS -Dleveldb.mmap=false "
export JAVA_OPTS=" $JAVA_OPTS -Djboss.jgroups.transport.site=s1 "
export JAVA_OPTS=" $JAVA_OPTS -Djboss.jgroups.transport.rack=r1 "
export JAVA_OPTS=" $JAVA_OPTS -Djboss.jgroups.transport.machine=$HOST_NAME "


echo "============================================================="
echo "   KHAN [provisioning]              http://www.opennaru.com/ "
echo "   JBoss DataGrid 6.3.1             service@opennaru.com"
echo "-------------------------------------------------------------"
echo "JBOSS_HOME=$JBOSS_HOME"
echo "DOMAIN_BASE=$DOMAIN_BASE"
echo "SERVER_NAME=$SERVER_NAME"
echo "CONFIG_FILE=$CONFIG_FILE"
echo "BIND_ADDR=$BIND_ADDR"
echo "PORT_OFFSET=$PORT_OFFSET"
echo "MULTICAST_ADDR=$MULTICAST_ADDR"
echo "CONTROLLER=$CONTROLLER_IP:$CONTROLLER_PORT"
#echo "CONSOLE=http://$CONTROLLER_IP:$CONSOLE_PORT"
echo "============================================================="
