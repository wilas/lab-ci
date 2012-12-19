# -*- coding: utf-8 -*-
import beer

def before_all(context):
    beer.app.config['TESTING'] = True
    context.client = beer.app.test_client()

def before_tag(context, tag):
    if 'beerdesc' in tag:
        beer.app.config['BEER_JSON'] = 'tests_json/test_beer_shortage.json'
    if 'encode' in tag:
        beer.app.config['BEER_JSON'] = 'tests_json/test_beer_encode.json'

def after_tag(context, tag):
    if 'beerdesc' or 'encode' in tag:
        beer.app.config['BEER_JSON'] = 'beerpoint.json'
    if 'encode' in tag:
        beer.app.config['BEER_JSON'] = 'beerpoint.json'

def after_all(context):
    pass
