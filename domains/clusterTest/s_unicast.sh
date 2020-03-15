#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.2.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------


#java -cp jgroups-3.2.5.Final.jar org.jgroups.tests.McastSenderTest -mcast_addr 224.10.10.10 -port 5555
#java -cp jgroups-3.2.5.Final.jar org.jgroups.tests.McastSenderTest -mcast_addr 224.21.1.105 -port 45555

java -Djboss.default.jgroups.stack=udp -Djgroups.bind_addr=192.168.110.111 -cp jgroups-3.2.5.Final.jar org.jgroups.tests.UnicastTest -name node1
