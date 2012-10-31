class git {

    $uid = 301
    #$uid = 1000

    group { "git":
        ensure => present,
        gid    => $uid,
    }

    #more about git user here: http://git-scm.com/book/en/Git-on-the-Server-Setting-Up-the-Server
    user { "git":
        ensure     => present,
        home       => "/home/${name}",
        managehome => true,
        uid        => $uid,
        gid        => "git",
        #password   => "!",
        shell      => "/usr/bin/git-shell",
        system     => true,
    }

    #in basic package
    #package { ["git", "perl-Git"]:
    #    ensure => installed,
    #}

}
