# Intro

Topic: BDD (python) flask and tornado webapps. Play with various tools supporting BDD, e.g. Selenium, twill.

BDD framework: behave

App desc.: beerpoint - app loading data from given json file and show them in the user browser (beer grouped in styles).
Created for fun and as an example flask and/or tornado app.


# Prepare Env. - install dependencies

Choose one of methods:

1. Use pip (You may consider using [virtualenv](http://www.virtualenv.org/en/latest/) to create isolated Python environments.):
```
    easy_install pip
    pip install -r requirements.txt
    #pip freeze -l > requirements.dump #dump deps.
```

2. Use locro machine:
```
    vagrant up locro
    ssh root@77.77.77.133 #locro -> /vagrant dir
    vagrant destroy locro
```

3. Use pythonbrew:
 - more here: http://suvashthapaliya.com/blog/2012/01/sandboxed-python-virtual-environments/


# TDD - play with nose:

```
    cd py_simple_tdd
    nosetests -v --nocapture #check all tests 
    nosetests -v --nocapture -a will_fail=False #check all not taged  will_fail=True
    nosetests -v --nocapture -a \!will_fail #check all not taged  will_fail=True
    nosetests --with-coverage -a \!will_fail --cover-tests #check tests and show coverage
```
## Links
 - nose intro: http://ivory.idyll.org/articles/nose-intro.html
 - nose howto: https://nose.readthedocs.org/en/latest/writing_tests.html

# BDD - play with behave:

```
    cd py_simple_bdd
    behave simple.feature #test that feature
    behave simple.feature -w #test wip taged scenarios in that feature

    #if features dir exist, e.g. in py_beer_flask
    cd py_beer_flask
    behave #test all features
    behave -w #test wip taged scenarios
```


## General behave information

Links:
 - Behave tutorial: http://packages.python.org/behave/tutorial.html
 - Gherkin: http://packages.python.org/behave/gherkin.html
 - Environmental control: http://packages.python.org/behave/tutorial.html#environmental-controls
 - Cucumber book: http://pragprog.com/book/hwcuc/the-cucumber-book


Behave cheet sheet:
 - Given: put the system in a known state before the user (or external system) starts interacting with the system. 
 - When: describe the key action (This is the interaction with your system which should (or perhaps should not) cause some state to change)
 - Then: we observe outcomes (should be related to the business value/benefit in your feature description)


Feature example:

```
Feature: Good beer point

    Scenario: Checking that beer point exist
        When Looking at home page
        Then We see beer point name
        And We see "Beer Point" in title

    Scenario: Amazing beer choices
        When Looking at home page
        Then We see beer styles
            | type          |
            | brown ale     |
            | pale ale      |
            | mild ale      |
            | belgian ale   |
            | stout         |
            | lambic        |
            | wheat         |
            | pale lager    |
            | dark lager    |
```

## Pure flask (py_beer_flask{,_blueprint})

 - use werkzeug client: http://flask.pocoo.org/docs/testing/

    ```
        cat py_beer_flask/features/environment.py
        --> context.client = beer.app.test_client()
    ```
 - allow change test configuration in fly

    ```
        cat py_beer_flask/features/environment.py
        --> beer.app.config['BEER_JSON'] = 'tests_json/test_beer_shortage.json'
    ```
 - fast execution
 - more designed for testing API responses then UI
 - in-process testing


## Tests supported by selenium (py_beer_flask_selenium)

 - compatible with several browser automation tools
 - out-of-process testing
 - good for testing UI
 - lauch webbrowser and make 'live' test
    - good for complex testing e.g with javascript
    - full interaction with browser (back, forward, reload, cookies, etc.)
    - loading page take time - needed timer to give page a time to load 
    - X required
    if use locro then X forwarding needed (proper package are already installed):

    ```
        ssh -X root@77.77.77.133 #locro
    ```
 - run app in spawn process then lauch webbrowser in main thread
    - lauching webbrowser is slow
    - not allow change configuration in fly - for each scenario process must be spawn and terminated after scenario
 - Links
    - python selenium lib: http://pypi.python.org/pypi/selenium
    - python selenium docs: http://selenium-python.readthedocs.org/en/latest/index.html
    - example: http://testingbot.com/support/getting-started/behave.html
    - selenium standalone: https://gist.github.com/daemianmack/1099713
    - simple WSGI HTTP server - wsgiref.simple_server: http://docs.python.org/2/library/wsgiref.html#module-wsgiref.simple_server
    - !! high-level wrapper for Selenium (more pythonic) - Splinter: http://splinter.cobrateam.info/docs/


## Tests supported by twill (py_beer_flask_twill)

 - use wsgi_intercept and mechnize in background
 - simple and a lot of functions (faster then selenium, no webbrowser needed)
 - allow change test configuration in fly
 - fast execution
 - twill is dead (last version 0.9 released 2007) but still useful for easyfying browser-like tasks
 - caching app object needed: 'the function passed into wsgi_intercept is called once for each intercepted connection, 
 but we only want to create the WSGI app object once.' - http://ivory.idyll.org/articles/twill-and-wsgi_intercept.html

    ```
        cat py_beer_flask_twill/features/environment.py
        --> twill.add_wsgi_intercept('127.0.0.1', 8000, lambda : context.app)
    ```
 - Links:
    - hpage: http://twill.idyll.org/
    - src code: http://pydoc.net/twill/latest/
    - example: http://www.advogato.org/article/874.html
    - twill adapted to flask: https://github.com/jarus/flask-testing/blob/master/flask_testing/twill.py


## Tests supported by wsgi_intercept + mechanize (py_beer_flask_intercept) 

 - simple but everything must be parse manually (e.g. find form to submit): no methods for matching text in responses
 - allow change test configuration in fly
 - fast execution
 - Links:
     - wsgi_intercept docs: http://code.google.com/p/wsgi-intercept/
     - ! mechanize as a browser: http://stockrt.github.com/p/emulating-a-browser-in-python-with-mechanize/
     - good django example: https://gist.github.com/1637965


## Flask in Tornado - tests supported by selenium (py_beer_flask_tornado)
 - same as flask with selenium
 - sample/howto run flask in tornado: `py_beer_flask_tornado/t_beer.py`
 - Links:
    - ! run flask in tornado service: http://flask.pocoo.org/docs/deploying/others/
    - mix flask with tornado: https://gist.github.com/1441063
    - mix flask with tornado: http://stackoverflow.com/questions/8143141/using-flask-and-tornado-together


## Tornado App - tests supported by selenium (py_beer_tornado)
 - same as flask with selenium
 - sample tornado app: `py_beer_tornado/beer.py`
 - Links:
    - tornado hello world: https://github.com/facebook/tornado/blob/master/demos/helloworld/helloworld.py
    - tornado wsgi test: https://github.com/facebook/tornado/blob/master/tornado/test/wsgi_test.py


# Bibliography

## Other BDD python libs:
 - lettuce: http://lettuce.it/
 - pycukes: http://pypi.python.org/pypi/pycukes/0.1

## Other libs for testing wsgi apps:
 - webtest: http://webtest.pythonpaste.org/en/latest/

## Flask
 - blueprint: http://flask.pocoo.org/docs/blueprints/
 - factories, conf_name: http://flask.pocoo.org/docs/patterns/appfactories/
 - templates: http://flask.pocoo.org/docs/tutorial/templates/
 - !!! large apps (template,blueprint example): https://github.com/mitsuhiko/flask/wiki/Large-app-how-to
 - flask bone: https://github.com/imwilsonxu/fbone
 - pattern creating app using function: http://flask.pocoo.org/snippets/20/
 - unittest flask: http://packages.python.org/Flask-Testing/

## Tornado
 - autoreload: http://www.tornadoweb.org/documentation/autoreload.html
 - options (useful to change conf.): http://www.tornadoweb.org/documentation/options.html
 - !!! overview: http://www.tornadoweb.org/documentation/overview.html
 - template: http://www.tornadoweb.org/documentation/template.html

