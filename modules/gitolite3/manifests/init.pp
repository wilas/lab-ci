class gitolite3 {

    $uid = 497
    $user = "gitolite3"
    $group = "gitolite3"
    
    $gitolite3_dir = "/var/lib/gitolite3"
    $gitolite3_guard_dir = "${gitolite3_dir}/.gitolite-puppet-guard"


    #
    # From author gitolite3: http://sitaramc.github.com/gitolite/repos.html
    # WARNING: Do NOT add new repos or users manually on the server. 
    # Gitolite users, repos, and access rules are maintained by making changes 
    # to a special repo called 'gitolite-admin' and pushing those changes to the server.
    #
    # That puppet module use gitolite-admin repo to manage gitolite server, but do it localy,
    # so stop manage gitolite/git using gitolite-admin repo, instead use puppet gitolite3::repo
    # 
    #
    # pubkeys obtained from elsewhere: http://sitaramc.github.com/gitolite/special.html
    # adding and removing repos: http://sitaramc.github.com/gitolite/repos.html



    # Package create gitolite3 group and user automaticly
    package { "gitolite3":
        ensure => installed,
    }

    group { "${group}":
        ensure   => present,
        gid      => "${uid}",
        system   => true,
        require  => Package["gitolite3"],
    }

    user { "${user}":
        ensure     => present,
        home       => "${gitolite3_dir}",
        managehome => true,
        uid        => "${uid}",
        gid        => "${group}",
        system     => true,
        shell      => "/bin/sh",
        require    => Package["gitolite3"],
    }
    
    # run script building repository and skeleton for configuration
    exec { "gitolite_setup":
        command => "/bin/su - ${user} -c '/usr/bin/gitolite setup -a admin'",
        path    => "/bin:/sbin:/usr/bin:/usr/sbin",
        creates => ["${gitolite3_dir}/repositories","${gitolite3_dir}/projects.list","${gitolite3_dir}/.gitolite"],
        require => Package['gitolite3'],
    }

    # create gitolite3 puppet managment directory and some scripts
    file {
        "${gitolite3_guard_dir}":
            ensure => directory,
            mode   => 0755,
            owner  => "${user}",
            group  => "${group}";
        "${gitolite3_guard_dir}/update_gitolite_admin.sh":
            ensure  => file,
            mode    => 0750,
            owner   => "${user}",
            group   => "${group}",
            content => template("gitolite3/update_gitolite_admin.sh.erb");
    }

    # clone gitolite-admin repo in gitolite3_guard_dir
    exec { "gitolite_puppet_guard":
        command => "/usr/bin/git clone ${gitolite3_dir}/repositories/gitolite-admin.git",
        cwd     => "${gitolite3_guard_dir}",
        user    => "${user}",
        path    => "/bin:/sbin:/usr/bin:/usr/sbin",
        creates => "${gitolite3_guard_dir}/gitolite-admin",
        require => [Exec["gitolite_setup"],File["${gitolite3_guard_dir}"]],
    }

    # use subconf: http://sitaramc.github.com/gitolite/g2incompat.html#g2i-name
    file { 
        "${gitolite3_guard_dir}/gitolite-admin/conf/auto":
            ensure  => directory,
            mode    => 0755,
            owner   => "${user}",
            group   => "${group}",
            recurse => true,
            purge   => true,
            notify  => Exec["update_gitolite_admin"],
            require => Exec["gitolite_puppet_guard"];
        "${gitolite3_guard_dir}/gitolite-admin/keydir":
            ensure  => directory,
            mode    => 0755,
            owner   => "${user}",
            group   => "${group}",
            recurse => true,
            purge   => true,
            notify  => Exec["update_gitolite_admin"],
            require => Exec["gitolite_puppet_guard"];
        "${gitolite3_guard_dir}/gitolite-admin/conf/gitolite.conf":
            ensure  => file,
            mode    => 0644,
            owner   => "${user}",
            group   => "${group}",
            source  => 'puppet:///modules/gitolite3/gitolite.conf',
            notify  => Exec["update_gitolite_admin"],
            require => Exec["gitolite_puppet_guard"];
    }
    
    # auto commit and push gitolite-admin changes
    exec { "update_gitolite_admin":
        command     => "/bin/su - ${user} -c '${gitolite3_guard_dir}/update_gitolite_admin.sh'",
        refreshonly => true,
        require     => File["${gitolite3_guard_dir}/update_gitolite_admin.sh"],
    }

}

