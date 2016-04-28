#!/bin/bash
# OSSEC uninstaller written by Paul McCarty April 2016 #

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi
 
echo "Stopping the OSSEC daemon..."
if [ -f /var/ossec/bin/ossec-control ];
        then /var/ossec/bin/ossec-control stop;
        else echo "Can't find ossec-control.  Trying ossec service.."
        service ossec stop || service ossec-hids stop
fi
 
echo "Removing /var/ossec directory..."
rm -rf /var/ossec
echo "Removing OSSEC init files..."
rm -rf /etc/ossec-init.conf /etc/init.d/*ossec* /etc/rc?.d/K??ossec /etc/rc?.d/S??ossec
echo "Removing OSSEC users..."
for i in `grep ossec /etc/passwd | gawk -F: '{print $1}'`; do /usr/sbin/userdel -r $i;done
echo "Removing OSSEC group..."
/usr/sbin/groupdel ossec
