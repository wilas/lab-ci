stage { "base": before => Stage["main"] }
stage { "last": require => Stage["main"] }

# basic config
class { "install_repos": stage => "base" }
class { "basic_package": stage => "base" }
class { "user::root": stage    => "base"}

# /etc/hosts
host { "$fqdn":
    ip           => "$ipaddress_eth1",
    host_aliases => "$hostname",
}

# firewall manage
service { "iptables":
    ensure => running,
    enable => true,
}
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
class { "basic_firewall": }


# Python Zone
class pyzone {
    package {
        "python":
            ensure => installed;
        "python-devel":
            ensure => installed;
        "python-setuptools":
            ensure => installed;
    }
    exec { "/usr/bin/easy_install pip":
        subscribe => Package["python-setuptools"],
        require   => Package["python-setuptools"],
        unless    => "/usr/bin/which pip",
    }
}
class { "pyzone": stage => "base" }

# app
package { 
    "Flask": 
        ensure     => "0.9",
        provider   => pip;
    "tornado": 
        ensure     => "2.4.1",
        provider   => pip;
    "simplejson": 
        ensure     => "3.0.5",
        provider   => pip;
}

# tests
package { 
    "behave":
        ensure     => "1.2.2",
        provider   => pip;
    "nose":
        ensure     => "1.2.1",
        provider   => pip;
    "coverage":
        ensure     => "3.6b3",
        provider   => pip;
}

# tests support
package {
    "wsgi-intercept": #intercept
        ensure     => "0.5.1",
        provider   => pip;
    "mechanize": #intercept
        ensure     => "0.2.5",
        provider   => pip;
    "selenium": #selenium, tornado
        ensure     => "2.28.0",
        provider   => pip;
    "twill": #twill
        ensure     => "0.9",
        provider   => pip;
    "BeautifulSoup": #all
        ensure     => "3.2.1",
        provider   => pip;
}

# selenium need X to open webbrowser
# use `ssh -X root@host` to enables X11 forwarding
package { ["firefox", "xorg-x11-xauth"]:
    ensure => installed,
}

firewall { "100 allow run beers python apps":
    state  => ['NEW'],
    dport  => '8000',
    proto  => 'tcp',
    action => accept,
}
