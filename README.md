# ossec_automation

OSSEC automation scripts written by Paul McCarty April 2016
Installer installs *only* the agent.  I suggest you build the server from source as per the documentation at https://ossec.github.io/docs/.  The uninstaller script will remove *any* OSSEC installation:  server or agent.

Tested in Cent 6.x, Redhat 6.x and Ubuntu 16.04

Verified to work on OSSEC versions:
2.7, 2.7.1, 2.8, 2.8.1, 2.8.2, 2.8.3 and 2.9.0beta5

NOTE: Running the installer on Redhat will need access to the EPEL and REMI repos as the ossec-hids rpm needds access to inotify.  
Here are the steps to install the repos:
rpm -ivh ftp://ftp.pbone.net/mirror/dl.iuscommunity.org/pub/ius/archive/Redhat/6/i386/epel-release-6-5.noarch.rpm
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sed -i '0,/enabled=0/s/enabled=0/enabled=1/g' /etc/yum.repos.d/remi.repo
Then run the installer.
