# -*- coding: utf-8 -*-
import twill
import StringIO

import beer_app

def before_all(context):
    context.baseurl = 'http://127.0.0.1:8000'
    twill.set_output(StringIO.StringIO())
    twill.commands.clear_cookies()
    context.app = beer_app.create_app()
    context.app.config['TESTING'] = True
    # fn=(lambda : context.app), it help create the WSGI app object only once, 
    # because function passed into wsgi_intercept is called 
    # once for each intercepted connection
    # more here: http://ivory.idyll.org/articles/twill-and-wsgi_intercept.html
    twill.add_wsgi_intercept('127.0.0.1', 8000, lambda : context.app)
    context.browser = twill.get_browser()

def before_tag(context, tag):
    context.beer_json = context.app.config['BEER_JSON']
    if 'beerdesc' in tag:
        context.app.config['BEER_JSON'] = 'tests_json/test_beer_shortage.json'
    if 'encode' in tag:
        context.app.config['BEER_JSON'] = 'tests_json/test_beer_encode.json'

def after_tag(context, tag):
    context.app.config['BEER_JSON'] = context.beer_json

def after_all(context):
    twill.remove_wsgi_intercept("127.0.0.1","8000")
    twill.commands.reset_output()
