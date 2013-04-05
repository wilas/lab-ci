define gitolite3::repo( $conf_file, $ensure,  $bare_src='' ) {
    include gitolite3

    file { "${gitolite3::gitolite3_guard_dir}/gitolite-admin/conf/auto/${name}.conf":
        ensure  => $ensure,
        mode    => '0644',
        owner   => $gitolite3::user,
        group   => $gitolite3::group,
        source  => $conf_file,
        notify  => Exec['update_gitolite_admin'],
        require => File["${gitolite3::gitolite3_guard_dir}/gitolite-admin/conf/auto"],
    }

    if $ensure == 'absent' {
        # remove git repo
        file { "${gitolite3::gitolite3_dir}/repositories/${name}.git":
            ensure  => absent,
            owner   => $gitolite3::user,
            group   => $gitolite3::group,
            recurse => true,
            force   => true,
        }
    }
    elsif $ensure == 'present' and $bare_src != '' {
        exec { 'restore_bare_repo':
            command => "/bin/cp -R ${bare_src} ${gitolite3::gitolite3_dir}/repositories/",
            path    => '/bin:/sbin:/usr/bin:/usr/sbin',
            creates => "${gitolite3::gitolite3_dir}/repositories/${name}.git",
            require => Exec['gitolite_puppet_guard'],
        }
        # manage restored repo owner,group
        file { "${gitolite3::gitolite3_dir}/repositories/${name}.git":
            ensure  => present,
            mode    => '0664',
            owner   => $gitolite3::user,
            group   => $gitolite3::group,
            recurse => true,
            require => Exec['restore_bare_repo'],
        }
    }
}

