# Description

CI: gitolite + gitweb; jenkins + TDD:... + BDD:...

## VM description:

 - OS: Scientific linux 6
 - git server: guillotine
 - jenkins server: headsman

## Good to know

### gitolite3::repo create:

```ruby

    gitolite3::repo { "blue":
        conf_file => "/vagrant/sample/blue.conf",
        ensure    => present,
    }

```

### gitolite3::repo restore:

```ruby

    gitolite3::repo { "red":
        conf_file => "/vagrant/sample/red.conf",
        ensure    => present,
        bare_src  => "/vagrant/sample/red.git",
    }

```

## Bibliography

### Git

 - github book: http://git-scm.com/book/en/Git-on-the-Server-Setting-Up-the-Server
 - how to setup own git server: http://tumblr.intranation.com/post/766290565/how-set-up-your-own-private-git-server-linux

### Gitolite

 - github book: http://git-scm.com/book/en/Git-on-the-Server-Gitolite
 - !!! adding and removing repos: http://sitaramc.github.com/gitolite/repos.html
 - moving pre-existing repos: http://sitaramc.github.com/gitolite/g2/moverepos.html
 - subconf command: http://sitaramc.github.com/gitolite/g2incompat.html#g2i-name
 - do not panic: http://sitaramc.github.com/gitolite/emergencies.html
 - example group and repositories config.: http://www.frederikkonietzny.de/2012/08/how-to-install-gitolite-and-git-web-on-ubuntu-12-04/
 - gilolite step by step: http://www.bigfastblog.com/gitolite-installation-step-by-step

### Gitweb

 - github book: http://git-scm.com/book/en/Git-on-the-Server-GitWeb
 - gitweb on centos6: http://monkeyswithbuttons.wordpress.com/2012/03/28/gitolite-git-daemon-gitweb-on-centos-6/

### Jenkins

