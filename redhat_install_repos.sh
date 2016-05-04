#!/bin/bash
# Redhat needs to install EPEL and REMI to get to the inotify app.  You DON'T have to run this for CentOS #

rpm -ivh ftp://ftp.pbone.net/mirror/dl.iuscommunity.org/pub/ius/archive/Redhat/6/i386/epel-release-6-5.noarch.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
if [ -f /etc/yum.repos.d/remi.repo ];
        then sed -i '0,/enabled=0/s/enabled=0/enabled=1/g' /etc/yum.repos.d/remi.repo;
else echo "REMI not installed, process failed.  Please install EPEL and REMI manually.";
fi


