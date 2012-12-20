from multiprocessing import Process
from wsgiref.validate import validator
from wsgiref.simple_server import make_server
import selenium.webdriver

import beer

def before_all(context):
    beer.app.config['TESTING'] = True
    # DEBUG == False if testing flask.app.run with selenium 
    # otherwise it make f*** mess !!!
    beer.app.config['DEBUG'] = False
    context.baseurl = "http://127.0.0.1:8000/"
    context.browser = selenium.webdriver.Firefox()

def before_scenario(context, scenario):
    context.beer_json = beer.app.config['BEER_JSON']
    if 'beerdesc' in scenario.tags:
        beer.app.config['BEER_JSON'] = 'tests_json/test_beer_shortage.json'
    if 'encode' in scenario.tags:
        beer.app.config['BEER_JSON'] = 'tests_json/test_beer_encode.json'
    # run app in subprocess
    # context.wsgi = make_server("", 8000, beer.app)
    context.wsgi = make_server("", 8000, validator(beer.app))
    context.server = Process(target=context.wsgi.serve_forever)
    context.server.start()

def after_scenario(context, scenario):
    beer.app.config['BEER_JSON'] = context.beer_json
    context.wsgi.shutdown
    context.server.terminate()
    context.server.join()

def after_all(context):
    context.browser.quit()
