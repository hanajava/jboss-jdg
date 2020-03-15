#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.2.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ../env.sh

# 관리 인터페이스 IP와 포트
export HOST=$CONTROLLER_IP
export PORT=$CONTROLLER_PORT

# 관리 인터페이스 접속 계정
export USERNAME="wasadm"
export PASSWORD="opennaru!2"

# 체크 주기(초)
export INTERVAL=30

PID=`ps -ef | grep java | grep "DJBOSS_STANDALONE_MONITORING_${HOST}_${PORT}" | awk '{print $2}'`
echo $PID

if [ e$PID != "e" ]
then
    echo "JBOSS_STANDALONE_MONITORING is already RUNNING..."
    exit;
fi

export JAVA_OPTS="-DJBOSS_STANDALONE_MONITORING_${HOST}_${PORT}"

nohup ./standalone_mon.sh -host=${HOST} -port=${PORT} -username=${USERNAME} -password=${PASSWORD} -interval=${INTERVAL} >> log/monitoring-standalone-${HOST}-${PORT}.log 2>&1 & 

