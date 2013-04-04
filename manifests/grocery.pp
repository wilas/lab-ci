# Git/Gitolite server

# Node global
exec { 'clear-firewall':
    command     => '/sbin/iptables -F',
    refreshonly => true,
}
exec { 'persist-firewall':
    command     => '/sbin/iptables-save >/etc/sysconfig/iptables',
    refreshonly => true,
}
Firewall {
    subscribe => Exec['clear-firewall'],
    notify    => Exec['persist-firewall'],
}

# Include classes - search for classes in *.yaml/*.json files
hiera_include('classes')
# Classes order
Class['yum_repos'] -> Class['basic_package'] -> Class['user::root']
Class['basic_package'] -> Class['gitolite3'] -> Class['gitolite3::gitweb']
# Extra firewall rules for gitweb and + git-saemon
firewall { '100 allow gitweb-apache':
    state  => ['NEW'],
    dport  => '80',
    proto  => 'tcp',
    action => accept,
}
firewall { '100 allow git-deamon':
    state  => ['NEW'],
    dport  => '9418',
    proto  => 'tcp',
    action => accept,
}

# In real world from DNS
host { $fqdn:
    ip           => $ipaddress_eth1,
    host_aliases => $hostname,
}

# Manage git repos + users

# basic users
#git::authorized_key { 'elk':
#    key => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAzklfofBRMF0doSKawOD0NQaq2z5VJUnsE3KNvEOln+l2BwHM2k2IdEXIfgR+BGUy+wz2wbDSiHVSEoqxX9tfnZSYxdI3IH8goNkkjdKy16r/cm/QEn5sSXgu0RowegTIKplFYU1CWNPlCViGXoUVatwEC2Byo9tz7/kMebQetAoeEMkRH0t/3pkgWqNHy8PDYUASp8PUnKUFcWhUyEokzfPxFllDBjdcMKpx6Iwk/iX/3LNmkXZvSQ6fbNj4a4oCKyx8BJBosUX/bopa0rhCZ6NGP0FHZsLZ9STO8fM5O921kMn7cDxe1MQwDTzvTl9ZJIfCzgZoySqHQ82JzR4nSQ==',
#}
# basic repos
#git::repo { 'trout':
#    ensure => present,
#}


# Manage gitolite repos + users
# basic repos
gitolite3::repo { 'blue':
    ensure    => present,
    conf_file => '/vagrant/samples/repos_garden/blue.conf',
}
gitolite3::repo { 'red':
    ensure    => present,
    conf_file => '/vagrant/samples/repos_garden/red.conf',
    bare_src  => '/vagrant/samples/repos_garden/red.git',
}
gitolite3::repo { 'green':
    ensure    => absent,
    conf_file => '/vagrant/samples/repos_garden/green.conf',
}
# basic users
gitolite3::guser { 'redman':
    ensure   => present,
    key_file => '/vagrant/samples/repos_garden/id_rsa.redman.pub',
}

# repos to play with jenkins
gitolite3::repo { 'py_beer_flask':
    ensure    => present,
    conf_file => '/vagrant/samples/repos_garden/py_beer_flask.conf',
}

