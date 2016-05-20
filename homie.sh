#!/bin/bash
redhat_weight=0
debian_weight=0
ubuntu_weight=0
centos_weight=0

el_linux () {
echo "This is EL linux"

}

deb_linux () {
echo "This is debian derivative linux"

}

lsb_exist () {
echo -n "lsb_release exists at "; which lsb_release


}


if [ -f /etc/redhat-release ] && [ ! -f /etc/debian_version ]; then
#	redhat_weight=$(($redhat_weight + 6));
#	centos_weight=$(($centos_weight + 6));
	el_linux
elif [ -f /etc/debian_version ] && [ ! -f /etc/redhat-release ]; then
#       debian_weight=$(($debian_weight + 6));
#       ubuntu_weight=$(($ubuntu_weight + 6));
	deb_linux
fi

	
which lsb_release && lsb_exist



echo "RESULTS"
echo -n  "Redhat weight = "; echo $redhat_weight
echo -n  "Debian weight = "; echo $debian_weight
echo -n  "Ubuntu weight = "; echo $ubuntu_weight
echo -n  "Debian weight = "; echo $centos_weight
