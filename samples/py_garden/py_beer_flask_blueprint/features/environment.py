# -*- coding: utf-8 -*-
import beer_app

def before_all(context):
    context.app = beer_app.create_app()
    context.app.config['TESTING'] = True
    context.client = context.app.test_client()

def before_tag(context, tag):
    context.beer_json = context.app.config['BEER_JSON']
    if 'beerdesc' in tag:
        context.app.config['BEER_JSON'] = 'tests_json/test_beer_shortage.json'
    if 'encode' in tag:
        context.app.config['BEER_JSON'] = 'tests_json/test_beer_encode.json'

def after_tag(context, tag):
    context.app.config['BEER_JSON'] = context.beer_json

def after_all(context):
    pass
