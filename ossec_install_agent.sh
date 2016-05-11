#!/bin/bash

serverip=192.168.0.254 # Put your own OSSEC server's IP address here.
osseccf=/var/ossec/etc/ossec.conf

redhat () {
yum install -y http://www5.atomicorp.com/channels/ossec/centos/6/x86_64/RPMS/ossec-hids-2.8.3-53.el6.art.x86_64.rpm
yum install -y http://www5.atomicorp.com/channels/ossec/centos/6/x86_64/RPMS/ossec-hids-client-2.8.3-53.el6.art.x86_64.rpm
}

debian () {
wget http://ossec.wazuh.com/repos/apt/ubuntu/pool/main/o/ossec-hids-agent/ossec-hids-agent_2.8.3-3wily_amd64.deb -O /tmp/debian_ossec_agent.deb
apt-get install -y /tmp/debian_ossec_agent.deb
}

if [ -f /etc/redhat-release ]; 
	then redhat; 
elif [ -f /etc/debian_version ]; 
	then debian; 
fi

echo "Backing up original $osseccf file..."
if [ -f $osseccf ]; then mv $osseccf $osseccf.orig.`date +"%m%d%y%T"`;fi
echo "Creating new ossec.conf that just points at server IP address."
cat > $osseccf << EOL
<ossec_config>
  <client>
    <server-ip>$serverip</server-ip>
  </client>
</ossec_config>
EOL

echo "Restarting the OSSEC agent software..."
if [ -f /var/ossec/bin/ossec-control ];
        then /var/ossec/bin/ossec-control restart;
        else echo "Can't find ossec-control.  Trying ossec service.."
        service ossec restart || service ossec-hids restart
fi

