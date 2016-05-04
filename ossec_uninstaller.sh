#!/bin/bash
# OSSEC uninstaller written by Paul McCarty April 2016 #
# Tested in Cent 6.x and Ubuntu 16.04 #
# Using OSSEC versions 2.7, 2.7.1, 2.8, 2.8.1, 2.8.2, 2.8.3 and 2.9.0beta5 #

tarloc=/tmp/ossec-backup-$(date +"%m-%d-%y-%T").tgz


redhat () {
echo "Removing any OSSEC RPMs:"
rpm -qa |grep -i ossec
for i in `rpm -qa |grep -i ossec`; do yum remove -y $i; done
}

debian () {
echo "Removing any OSSEC DEBs: "
apt-get remove -y  "^ossec.*"
}

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

echo "Tarring up the OSSEC files before we continue..."
tar zcf ${tarloc} /var/ossec /etc/init.d/*ossec*
echo; echo "### Your backup is in $tarloc ###"; echo
echo "###############################################################################"
echo "Stopping the OSSEC daemon..."
if [ -f /var/ossec/bin/ossec-control ];
        then /var/ossec/bin/ossec-control stop;
        else echo "Can't find ossec-control.  Trying ossec service.."
        service ossec stop || service ossec-hids stop
fi
echo "###############################################################################"
echo "Removing /var/ossec directory..."
rm -rf /var/ossec
echo "###############################################################################"
echo "Removing OSSEC init files..."
rm -rf /etc/ossec-init.conf /etc/init.d/*ossec* /etc/rc?.d/K??ossec /etc/rc?.d/S??ossec
echo "###############################################################################"
echo "Removing OSSEC users : "
grep ossec /etc/passwd | gawk -F: '{print $1}'
for i in $(grep ossec /etc/passwd | gawk -F: '{print $1}'); do /usr/sbin/userdel -r $i;done
echo "###############################################################################"
echo "Removing OSSEC group..."
/usr/sbin/groupdel ossec
echo "###############################################################################"

if [ -f /etc/redhat-release ];
        then echo "REDHAT"; redhat;
elif [ -f /etc/debian_version ];
        then echo "DEBIAN"; debian;
fi

echo "###############################################################################"
echo "ALL DONE! Exiting..."
