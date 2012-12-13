import wsgi_intercept.mechanize_intercept
import beer


def before_all(context):
    context.baseurl = "http://127.0.0.1:8000/"
    wsgi_intercept.add_wsgi_intercept('127.0.0.1', 8000, beer.create_app)
    context.browser = wsgi_intercept.mechanize_intercept.Browser()

    # Example:
    # response = context.browser.open(context.baseurl)
    # page = response.read()
    # print page


def after_all(context):
    wsgi_intercept.remove_wsgi_intercept("127.0.0.1",8000)
