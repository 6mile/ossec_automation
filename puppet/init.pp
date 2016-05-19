class ossec {

  package { 'inotify-tools':
     ensure => installed,
     provider => 'yum'
  }

  package { 'ossec':
     provider => 'rpm',
     ensure => installed,
     source => "http://www5.atomicorp.com/channels/ossec/centos/6/x86_64/RPMS/ossec-hids-2.8.3-53.el6.art.x86_64.rpm"
  }

  package { 'ossec-agent':
     provider => 'rpm',
     ensure => installed,
     source => "http://www5.atomicorp.com/channels/ossec/centos/6/x86_64/RPMS/ossec-hids-client-2.8.3-53.el6.art.x86_64.rpm"
  }

  file { "/var/ossec/etc/ossec.conf":
     ensure => file,
     source => "puppet:///modules/ossec/ossec.conf",
#    content => 'file(ossec/files/ossec.conf)',
     path => "/var/ossec/etc/ossec.conf",
     replace => true,
     owner => "root",
     group => "root",
     mode => 755,
  }

}


