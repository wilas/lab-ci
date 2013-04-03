## Git Zone

### gitolite3::repo - create new empty repo:

```ruby

    gitolite3::repo { "blue":
        ensure    => present,
        conf_file => "/vagrant/sample/blue.conf",
    }
```

### gitolite3::repo - restore bare repo:

```ruby

    gitolite3::repo { "red":
        ensure    => present,
        conf_file => "/vagrant/sample/red.conf",
        bare_src  => "/vagrant/sample/red.git",
    }
```

### enable repo for gitweb (vim red.conf)

```
repo red
    RW+                 =   redman
    R                   =   gitweb
```

test in webbrowser: 77.77.77.131/gitweb

test by run (read-only or set-up apache-auth.):  `git clone http://77.77.77.131/git/red.git`

### enable repo for git-daemon (read-only)(vim red.conf)

```
repo red
    RW+                 =   redman
    R                   =   daemon
```

test by run: `git clone git://77.77.77.131/red.git`

## Bibliography

### Git

 - !!! git protocols in github book: http://git-scm.com/book/en/Git-on-the-Server-The-Protocols
 - git in github book: http://git-scm.com/book/en/Git-on-the-Server-Setting-Up-the-Server
 - how to setup own git server: http://tumblr.intranation.com/post/766290565/how-set-up-your-own-private-git-server-linux

### Gitolite

 - gitolite in github book: http://git-scm.com/book/en/Git-on-the-Server-Gitolite
 - !!! adding and removing repos: http://sitaramc.github.com/gitolite/repos.html
 - moving pre-existing repos: http://sitaramc.github.com/gitolite/g2/moverepos.html
 - subconf command: http://sitaramc.github.com/gitolite/g2incompat.html#g2i-name
 - do not panic: http://sitaramc.github.com/gitolite/emergencies.html
 - example group and repositories config.: http://www.frederikkonietzny.de/2012/08/how-to-install-gitolite-and-git-web-on-ubuntu-12-04/
 - gitolite step by step: http://www.bigfastblog.com/gitolite-installation-step-by-step

### Gitweb

 - gitweb in github book: http://git-scm.com/book/en/Git-on-the-Server-GitWeb
 - !!! gitweb on centos6, git-deamon: http://monkeyswithbuttons.wordpress.com/2012/03/28/gitolite-git-daemon-gitweb-on-centos-6/
 - !!! git-http-backend: http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html
 - smart-http - gitolite author (suexec): http://sitaramc.github.com/gitolite/g2/ggshb.html
 - !!! smart-http and ldap auth.: http://loutilities.wordpress.com/2011/08/12/setting-up-git-with-apache-smart-https-and-ldap/
 - smart-http in github book: http://git-scm.com/2010/03/04/smart-http.html
 - suexec wrapper: http://linuxadminzone.com/quickly-setup-git-server-with-gitolite-gitweb-ssh-and-http-auth/
 - gitolite uid/gid>500 for gitweb: https://wincent.com/wiki/Troubleshooting_suexec_errors

### Gitlab

