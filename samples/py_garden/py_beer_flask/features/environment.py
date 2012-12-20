# -*- coding: utf-8 -*-
import beer

def before_all(context):
    beer.app.config['TESTING'] = True
    context.client = beer.app.test_client()

def before_tag(context, tag):
    context.beer_json = beer.app.config['BEER_JSON']
    if 'beerdesc' in tag:
        beer.app.config['BEER_JSON'] = 'tests_json/test_beer_shortage.json'
    if 'encode' in tag:
        beer.app.config['BEER_JSON'] = 'tests_json/test_beer_encode.json'

def after_tag(context, tag):
    beer.app.config['BEER_JSON'] = context.beer_json

def after_all(context):
    pass
