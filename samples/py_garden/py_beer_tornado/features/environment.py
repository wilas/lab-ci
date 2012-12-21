from multiprocessing import Process
import selenium.webdriver
import tornado.options

import beer

def before_all(context):
    context.baseurl = "http://127.0.0.1:8000/"
    context.browser = selenium.webdriver.Firefox()

def before_scenario(context, scenario):
    context.beer_json = tornado.options.options.beer_json
    if 'beerdesc' in scenario.tags:
        tornado.options.options.beer_json = 'tests_json/test_beer_shortage.json'
    if 'encode' in scenario.tags:
        tornado.options.options.beer_json = 'tests_json/test_beer_encode.json'
    # run app in subprocess
    context.server = Process(target=beer.run, args=('127.0.0.1', 8000))
    context.server.start()

def after_scenario(context, scenario):
    tornado.options.options.beer_json = context.beer_json
    context.server.terminate()
    context.server.join()

def after_all(context):
    context.browser.quit()
