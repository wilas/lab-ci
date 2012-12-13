from multiprocessing import Process
from wsgiref.validate import validator
from wsgiref.simple_server import make_server
import selenium.webdriver

import beer


def before_all(context):
    context.baseurl = "http://127.0.0.1:8000/"
    # context.wsgi = make_server("", 8000, beer.app)
    context.wsgi = make_server("", 8000, validator(beer.app))
    context.server = Process(target=context.wsgi.serve_forever)
    context.server.start()
    context.browser = selenium.webdriver.Firefox()

    # Example:
    # context.browser.get(context.baseurl)
    # import time
    # time.sleep(1)


def after_all(context):
    context.wsgi.shutdown
    context.server.terminate()
    context.server.join()
    context.browser.quit()
