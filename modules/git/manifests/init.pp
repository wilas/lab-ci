class git {

    $uid = 496

    group { 'git':
        ensure => present,
        gid    => $uid,
    }

    # More about git server here: http://git-scm.com/book/en/Git-on-the-Server-Setting-Up-the-Server
    user { 'git':
        ensure     => present,
        home       => "/home/${name}",
        managehome => true,
        uid        => $uid,
        gid        => 'git',
        shell      => '/usr/bin/git-shell',
        system     => true,
    }

    # In basic package
    #package { ['git', 'perl-Git']:
    #    ensure => installed,
    #}

}
