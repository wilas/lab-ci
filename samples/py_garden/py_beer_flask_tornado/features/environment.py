from multiprocessing import Process
import selenium.webdriver

import t_beer

def before_all(context):
    t_beer.app.config['TESTING'] = True
    context.baseurl = "http://127.0.0.1:8000/"
    context.browser = selenium.webdriver.Firefox()

def before_scenario(context, scenario):
    context.beer_json = t_beer.app.config['BEER_JSON']
    if 'beerdesc' in scenario.tags:
        t_beer.app.config['BEER_JSON'] = 'tests_json/test_beer_shortage.json'
    if 'encode' in scenario.tags:
        t_beer.app.config['BEER_JSON'] = 'tests_json/test_beer_encode.json'
    # run app in subprocess
    context.server = Process(target=t_beer.run, args=("", 8000))
    context.server.start()

def after_scenario(context, scenario):
    t_beer.app.config['BEER_JSON'] = context.beer_json
    context.server.terminate()
    context.server.join()

def after_all(context):
    context.browser.quit()
