node default {
        include custom_utils
        include ossec
}

class custom_utils {
        file_line { 'make sure domain entry exists':
                path   => '/etc/resolv.conf',
                line   => 'domain yourdomain.local',
                match  => '^domain',
        }
        file_line { 'add nameservers':
                path   => '/etc/resolv.conf',
                line   => "nameserver 8.8.8.8\nnameserver 8.8.4.4\nnameserver localhost",
                match  => '^nameserver',
        }

}

