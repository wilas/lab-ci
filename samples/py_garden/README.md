### Install nose, behave and other useful lib.

```
    easy_install pip
    pip install nose
    pip install coverage
    pip install behave
    pip install simplejson
```

### Howto use nose

```
    nosetests -v --nocapture -a will_fail=False
    nosetests -v --nocapture -a \!will_fail
    nosetests -v --nocapture 
    nosetests --with-coverage -a \!will_fail
```
