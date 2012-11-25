class gitolite3::gitweb {

    include apache
    include gitolite3
    #firewall module required

    # Known issues:
    #  gitweb - apache error 404: No projects found
    #    gitweb.cgi is executed directly, as the httpd user and without any environment settings
    #    more about problem: http://stackoverflow.com/questions/9777459/how-to-get-gitolite-gitweb-working-together
    #    use suexec module in apache to run under gitolite user: http://sitaramc.github.com/gitolite/g2/ggshb.html
    #    howto: http://linuxadminzone.com/quickly-setup-git-server-with-gitolite-gitweb-ssh-and-http-auth/
    #    enough is use: SuexecUserGroup gitolite3 gitolite3 in vhost (no wrapper needed)
    #
    #  gitweb - apache error 500: in suexec log - cannot run as forbidden uid
    #    suexec won’t execute under user/group have userid/groupid less than 500 (system)
    #    more here: https://wincent.com/wiki/Troubleshooting_suexec_errors
    #


    $projects_list = "${gitolite3::gitolite3_dir}/projects.list"
    $projectsroot = "${gitolite3::gitolite3_dir}/repositories"
    $gitweb_user = "${gitolite3::user}"
    $gitweb_group = "${gitolite3::group}"
    $gitweb_cgi_dir = "/var/www/git"


    # install gitweb and git-daemon
    package { ["gitweb","git-daemon"]:
        ensure  => installed,
        require => Package["httpd","gitolite3"],
    }
    
    # clean after package install
    file { "/etc/httpd/conf.d/git.conf":
        ensure  => absent,
        require => Package["gitweb"],
    }
        
    # usermod -a -G gitolite3 apache
    user { "apache":
        ensure  => present,
        groups  => "${gitolite3::group}",
        require => Package["gitweb"],
    }

    # gitweb config file
    file { "/etc/gitweb.conf":
        ensure  => file,
        mode    => 0644,
        owner   => "root",
        group   => "root",
        content => template("gitolite3/gitweb.conf.erb"),
        require => Package["gitweb"],
        notify  => Service["httpd"],
    }

    # TODO: change apache vhost -> should take as arg. template
    # use apache::vhost
    # check if apache service is notify automaticly
    file { "/etc/httpd/conf.d/20_gitweb.conf":
        ensure  => file,
        mode    => 0644,
        owner   => "root",
        group   => "root",
        content => template("gitolite3/apache_gitweb_vhost.conf.erb"),
        require => Package["gitweb"],
        notify  => Service["httpd"],
    }
   
    # directory in /var/www with cgi script - owner and group
    file { "${gitweb_cgi_dir}":
        ensure  => directory,
        owner   => "${gitweb_user}",
        group   => "${gitweb_group}",
        recurse => true,
        require => Package["gitweb"],
    }

    # git-deamon + xinetd.d to use git:// protocol
    file { "/etc/xinetd.d/git":
        ensure  => file,
        mode    => 0644,
        owner   => "root",
        group   => "root",
        content => template("gitolite3/git-xinetd.erb"),
        notify  => Service["xinetd"],
        require => Package["git-daemon"],
    }

    service { "xinetd":
        ensure     => running,
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
        require    => Package["git-daemon"],
    }
    
    firewall { "100 allow git-deamon":
        state  => ['NEW'],
        dport  => '9418',
        proto  => 'tcp',
        action => accept,
    }

}
