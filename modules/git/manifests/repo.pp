define git::repo($ensure=present){

    $repo = "/home/git/${name}"

    if $ensure == present {

        file { $repo:
            ensure => directory,
            owner  => 'git',
            group  => 'git',
            mode   => '0644',
        }

        # su - git && cd repo && git init --bare
        exec { "git init --bare ${name}":
            path    => '/bin:/sbin:/usr/bin:/usr/sbin',
            command => 'git init --bare',
            cwd     => $repo,
            creates => "${repo}/config",
            user    => 'git',
            group   => 'git',
            require => File[$repo]
        }

    } elsif $ensure == absent {
        file { $repo:
            ensure  => absent,
            recurse => true,
            force   => true,
        }
    }
}
