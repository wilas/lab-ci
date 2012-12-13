from multiprocessing import Process
import selenium.webdriver

import beer


def before_all(context):
    context.baseurl = "http://127.0.0.1:8000/"
    context.server = Process(target=beer.app.run, args=("", 8000))
    context.server.start()
    context.browser = selenium.webdriver.Firefox()

    # Example:
    # context.browser.get(context.baseurl)
    # import time
    # time.sleep(1)


def after_all(context):
    context.server.terminate()
    context.server.join()
    context.browser.quit()
