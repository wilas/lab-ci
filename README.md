# Description

CI: gitolite + gitweb; jenkins + TDD:... + BDD:...

## VM description:

 - OS: Scientific linux 6
 - git server: guillotine
 - jenkins server: headsman

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

### enable repo in gitweb `edit red.conf` (test: 77.77.77.131/gitweb):

```

repo red
    RW+                 =   redman
    R                   =   gitweb

```

### enable repo in git-daemon `red.conf` (test: git clone git://77.77.77.131/red.git):

```

repo red
    RW+                 =   redman
    R                   =   daemon

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
 - gitweb on centos6, git-deamon: http://monkeyswithbuttons.wordpress.com/2012/03/28/gitolite-git-daemon-gitweb-on-centos-6/
 - suexec wrapper: http://linuxadminzone.com/quickly-setup-git-server-with-gitolite-gitweb-ssh-and-http-auth/
 - suexec wrapper - gitolite author: http://sitaramc.github.com/gitolite/g2/ggshb.html
 - gitolite user/group uid/gid for gitweb: https://wincent.com/wiki/Troubleshooting_suexec_errors

### Jenkins

 - hpage: http://jenkins-ci.org/

## Copyright and license

Copyright 2012, the ci-ippon authors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

