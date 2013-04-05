define git::authorized_key($key) {

  ssh_authorized_key { "git@${name}":
    ensure => present,
    key    => $key,
    user   => 'git',
    type   => 'ssh-rsa',
  }
}
