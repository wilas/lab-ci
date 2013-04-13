class jenkins {

    include 'jvm'

    # repo key
    file { '/etc/pki/rpm-gpg/jenkins-ci.org.key':
        ensure => file,
        owner  => 'root',
        group  => 'root',
        mode   => '0444',
        source => 'puppet:///modules/jenkins/jenkins-ci.org.key',
    }

    # jenkins repo
    yumrepo { 'jenkins':
        enabled  => 1,
        descr    => 'Jenkins packages',
        baseurl  => 'http://pkg.jenkins-ci.org/redhat',
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/jenkins-ci.org.key',
        require  => File['/etc/pki/rpm-gpg/jenkins-ci.org.key'],
    }

    package { 'jenkins':
        ensure  => installed,
        require => [Yumrepo['jenkins'], Package['java']],
    }

    service { 'jenkins':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package['jenkins'],
    }
}
