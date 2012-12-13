import twill
import StringIO
import beer


def before_all(context):
    context.baseurl = "http://127.0.0.1:8000"
    twill.set_output(StringIO.StringIO())
    twill.commands.clear_cookies()
    # port must be int not string
    twill.add_wsgi_intercept("127.0.0.1", 8000, beer.create_app)
    context.browser = twill.get_browser()

    # Example:
    # context.browser.go(context.baseurl)
    # print context.browser.get_html()
    # print context.browser.get_title()    


def after_all(context):
    twill.remove_wsgi_intercept("127.0.0.1","8000")
    twill.commands.reset_output()
