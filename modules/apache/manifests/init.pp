class apache {

    $listen_ip = hiera('apache::listen_ip',false)
    $listen_port = hiera('apache::listen_port',80)
    $name_virtual_host = hiera('apache::listen_ip','*')

    package { 'httpd':
        ensure => installed,
    }

    service { 'httpd':
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require    => Package['httpd'],
        subscribe  => [File['/etc/httpd/conf/httpd.conf'], File['/etc/httpd/conf.d']],
    }

    # update: DefaultType text/html
    file {
        '/etc/httpd/conf/httpd.conf':
            ensure  => file,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            content => template('apache/httpd.conf.erb'),
            require => Package['httpd'];
        '/etc/httpd/conf.d':
            ensure  => directory,
            owner   => 'root',
            group   => 'root',
            mode    => '0644',
            recurse => true,
            require => Package['httpd'];
        '/etc/httpd/conf.d/welcome.conf':
            content => "NameVirtualHost ${name_virtual_host}:${listen_port}",
            require => [Package['httpd'],File['/etc/httpd/conf.d']],
            notify  => Service['httpd'];
    }
}
