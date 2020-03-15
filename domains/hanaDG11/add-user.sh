#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.3.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


. ./env.sh

JAVA_OPTS="$JAVA_OPTS -Djboss.server.config.user.dir=$DOMAIN_BASE/$SERVER_NAME/configuration "

$JBOSS_HOME/bin/add-user.sh $@
