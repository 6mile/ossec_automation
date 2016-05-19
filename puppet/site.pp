node 'paul-cent6-logstash-client.ad.corelogic.asia' {
        include custom_utils
        include accounts
        include ossec
}

class custom_utils {
        include stdlib
        package { ["nmap","vim-enhanced","traceroute",]:
                ensure => latest,
        }
        package { ["telnet","httpd",]:
                ensure => purged,
        }
        file_line { 'make sure domain entry exists':
                path   => '/etc/resolv.conf',
                line   => 'domain rpdata.local',
                match  => '^domain',
        }
        file_line { 'add nameservers':
                path   => '/etc/resolv.conf',
                line   => "nameserver 8.8.8.8\nnameserver 8.8.4.4\nnameserver localhost",
                match  => '^nameserver',
        }

}

