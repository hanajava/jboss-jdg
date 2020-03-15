#!/bin/sh
# -------------------------------------------------------------
#   KHAN [provisioning]              http://www.opennaru.com/
#   JBoss Data Grid Server 6.2.1
#
#   contact : service@opennaru.com
#   Copyright(C) 2014, opennaru.com, All Rights Reserved.
# -------------------------------------------------------------

echo java -cp jgroups-3.2.5.Final.jar org.jgroups.tests.McastReceiverTest -bind_addr 192.168.110.141 -mcast_addr 224.0.0.111 -port 55300
java -cp jgroups-3.2.5.Final.jar org.jgroups.tests.McastReceiverTest -bind_addr 192.168.110.141 -mcast_addr 224.0.0.111 -port 55300
