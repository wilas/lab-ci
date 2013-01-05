# -*- coding: utf-8 -*-
import re
import time
from BeautifulSoup import BeautifulSoup

@given('Beer point')
@when('Looking at home page')
def step(context):
    time.sleep(0.2) # let the page load
    context.browser.get(context.baseurl)
    assert context.browser.page_source

@then('We see beer point name')
def step(context):
    assert re.search('beer point name: \w+', context.browser.page_source)

@then('We see "{text}" in title')
def step(context, text):
    assert text in context.browser.title

@then('We see beer styles')
def step(context):
    for row in context.table:
        assert row['type'] in context.browser.page_source

@when('Number of pints for a beer is {text} 0')
def step(context, text):
    # base on text pattern
    if text == 'equal': pattern = 'pints=0'
    if text == 'greater than': pattern = 'pints=[1-9]'
    # find all beers descriptions
    beerslist = BeautifulSoup(context.browser.page_source).findAll('li')
    context.beerslist = []
    for beer_d in beerslist:
        # beers descriptions maching pattern add to context.beerslist
        if re.search(pattern ,beer_d.text):
            context.beerslist.append(str(beer_d))
    # check that pattern exist in page and we have good example to test
    assert re.search(pattern,context.browser.page_source)

@then('The Beer description is {text}')
def step(context, text):
    for beer_d in context.beerslist:
        if text == 'red':
            assert re.search('color=["\']red["\']', beer_d)
        if text == 'not red':
            assert not re.search('color=["\']red["\']', beer_d)
