#!/bin/bash

serverip=192.168.0.254 # Put your own OSSEC server's IP address here.
osseccf=/var/ossec/etc/ossec.conf

yum install -y http://www5.atomicorp.com/channels/ossec/centos/6/x86_64/RPMS/ossec-hids-2.8.3-53.el6.art.x86_64.rpm
yum install -y http://www5.atomicorp.com/channels/ossec/centos/6/x86_64/RPMS/ossec-hids-client-2.8.3-53.el6.art.x86_64.rpm

echo "Backing up original $osseccf file..."
mv $osseccf $osseccf.orig.`date +"%m%d%y%T"`
echo "Creating new ossec.conf that just points at server IP address."
echo "<ossec_config>" >> $osseccf
echo "  <client>" >> $osseccf
echo "    <server-ip>$serverip</server-ip>" >> $osseccf
echo "  </client>" >> $osseccf
echo "</ossec_config>" >> $osseccf

echo "Restarting the OSSEC agent software..."
if [ -f /var/ossec/bin/ossec-control ];
        then /var/ossec/bin/ossec-control restart;
        else echo "Can't find ossec-control.  Trying ossec service.."
        service ossec restart || service ossec-hids restart
fi

