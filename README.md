# ossec_automation version 0.2

OSSEC automation scripts written by Paul McCarty April 2016
Installer installs *only* the agent.  I suggest you build the server from source as per the documentation at https://ossec.github.io/docs/.  The uninstaller script will remove *any* OSSEC installation:  server or agent.

Uninstaller tested in Cent 6.x, Redhat 6.x and Ubuntu 16.04.  Installer is working for Cent and Ubuntu but see note below for Redhat.

Installer/Uninstaller verified to work on OSSEC versions:
2.7, 2.7.1, 2.8, 2.8.1, 2.8.2, 2.8.3 and 2.9.0beta5

NOTE: Running the installer on Redhat will need access to the EPEL and REMI repos as the ossec-hids rpm needds access to inotify.  
Run the provided redhat_install_repos.sh.  Once EPEL and REMI are installed you should be able to run the installer and have it find inotify and then install the OSSEC agent.

