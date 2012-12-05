# Description

CI: gitolite + gitweb; jenkins + TDD:... + BDD:...

## VM description:

 - OS: Scientific linux 6
 - git server: guillotine.farm
 - jenkins server: headsman.farm

## Good to know

### gitolite3::repo - create new empty:

```ruby

    gitolite3::repo { "blue":
        conf_file => "/vagrant/sample/blue.conf",
        ensure    => present,
    }
```

### gitolite3::repo - restore bare:

```ruby

    gitolite3::repo { "red":
        conf_file => "/vagrant/sample/red.conf",
        ensure    => present,
        bare_src  => "/vagrant/sample/red.git",
    }
```

### enable repo in gitweb 

```
repo red
    RW+                 =   redman
    R                   =   gitweb
```

test in webbrowser: 77.77.77.131/gitweb

(read-only or set-up apache-auth.) test by run: `git clone http://77.77.77.131/git/red.git`

### enable repo in git-daemon (read-only)

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
 - gilolite step by step: http://www.bigfastblog.com/gitolite-installation-step-by-step

### Gitweb

 - gitweb in github book: http://git-scm.com/book/en/Git-on-the-Server-GitWeb
 - !!! gitweb on centos6, git-deamon: http://monkeyswithbuttons.wordpress.com/2012/03/28/gitolite-git-daemon-gitweb-on-centos-6/
 - !!! git-http-backend: http://www.kernel.org/pub/software/scm/git/docs/git-http-backend.html
 - smart-http - gitolite author (suexec): http://sitaramc.github.com/gitolite/g2/ggshb.html
 - !!! smart-http and ldap auth.: http://loutilities.wordpress.com/2011/08/12/setting-up-git-with-apache-smart-https-and-ldap/
 - smart-http in github book: http://git-scm.com/2010/03/04/smart-http.html
 - suexec wrapper: http://linuxadminzone.com/quickly-setup-git-server-with-gitolite-gitweb-ssh-and-http-auth/
 - gitolite uid/gid>500 for gitweb: https://wincent.com/wiki/Troubleshooting_suexec_errors

### Jenkins

 - hpage: http://jenkins-ci.org/

## Copyright and license

Copyright 2012, Kamil Wilas (wilas.pl)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

