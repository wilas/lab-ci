define gitolite3::guser( $key_file, $ensure ) {
    include gitolite3

    file { "${gitolite3::gitolite3_guard_dir}/gitolite-admin/keydir/${name}.pub":
        ensure  => $ensure,
        mode    => 0644,
        owner   => "${gitolite3::user}",
        group   => "${gitolite3::group}",
        source  => "${key_file}",
        notify  => Exec["update_gitolite_admin"],
        require => File["${gitolite3::gitolite3_guard_dir}/gitolite-admin/keydir"],
    }
}
