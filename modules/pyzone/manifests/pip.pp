class pyzone::pip {

    package {
        "python":
            ensure => installed;
        "python-devel":
            ensure => installed;
        "python-setuptools":
            ensure => installed;
    }

    # for RedHat osfamily puppet pip provider require command pip-python (shit !)
    # it's older version (now 0.8) then installed by easy_install (1.2.1)
    # issue: http://projects.puppetlabs.com/issues/15980
    package { "python-pip":
        ensure => installed,
    }

    #exec { "/usr/bin/easy_install pip":
    #    subscribe => Package["python-setuptools"],
    #    require   => Package["python-setuptools"],
    #    unless    => "/usr/bin/which pip",
    #}
}
