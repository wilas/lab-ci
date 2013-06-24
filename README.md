# Description

Build continuous integration quazi development environment:
  - git repos easy in restore (gitolite, gitweb and git-daemon)
  - jenkins with extra plugins (e.g. git), jobs to automate tests
  - TDD/BDD for python (flask/tornado beerpoint apps) - [py-garden](samples/py_garden)

## VM description:

 - OS: Scientific linux 6
 - git server: grocery.farm
 - jenkins server: cook.farm
 - python play server: locro.farm

## Howto

 - create SL6 box using [vbkick-boxarium](https://github.com/wilas/vbkick-boxarium)
 - copy ssh_keys from [ssh-gerwazy](https://github.com/wilas/ssh-gerwazy)

```
    vagrant up
    ssh root@77.77.77.131 #grocery
    ssh root@77.77.77.132 #cook
    ssh root@77.77.77.133 #locro
    vagrant destroy
```

## More 

 - [git zone](Git.md)
 - [jenkins zone](Jenkins.md)


## Copyright and license

Copyright 2012-2013, Kamil Wilas (wilas.pl)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this work except in compliance with the License.
You may obtain a copy of the License in the LICENSE file, or at:

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

