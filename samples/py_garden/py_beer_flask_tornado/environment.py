from multiprocessing import Process
from selenium import webdriver
import t_beer


def before_all(context):
    context.baseurl = "http://127.0.0.1:8000/"
    context.server = Process(target=t_beer.run, args=('127.0.0.1', 8000))
    context.server.start()
    context.browser = webdriver.Firefox()

    # Example:
    # context.browser.get(context.baseurl)
    # import time
    # time.sleep(1)


def after_all(context):
    context.server.terminate()
    context.server.join()
    context.browser.quit()
