@when('Looking at home page')
def step(context):
    context.browser.get(context.baseurl)
    assert context.browser.page_source

@then('We see lager beer')
def step(context):
    assert 'lager' in context.browser.page_source

@then('We see Beer Point in title')
def step(context):
    assert 'Beer Point' in context.browser.title
