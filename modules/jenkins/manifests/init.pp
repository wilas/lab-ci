class jenkins {

    # repo key
    file { "/etc/pki/rpm-gpg/jenkins-ci.org.key":
        ensure => file,
        owner  => "root",
        group  => "root",
        mode   => "0444",
        source => "puppet:///modules/jenkins/jenkins-ci.org.key",
    }

    # jenkins repo
    yumrepo { "jenkins":
        enabled  => 1,
        descr    => "Jenkins packages",
        baseurl  => "http://pkg.jenkins-ci.org/redhat",
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/jenkins-ci.org.key',
        require  => File["/etc/pki/rpm-gpg/jenkins-ci.org.key"],
    }

    # java 1.7.0 not working yet good with jenkins
    package { "java":
        name => ["java-1.6.0-openjdk", "java-1.6.0-openjdk-devel"],
        ensure => installed,
    }

    package { "jenkins":
        ensure  => installed,
        require => [Yumrepo["jenkins"],Package["java"]],
    }

    service { "jenkins":
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package["jenkins"],
    }

}
