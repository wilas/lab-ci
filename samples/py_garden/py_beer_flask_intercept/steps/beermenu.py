@when('Looking at home page')
def step(context):
    response = context.browser.open(context.baseurl)
    context.page = response.read()
    assert context.page

@then('We see lager beer')
def step(context):
    assert 'lager' in context.page

@then('We see Beer Point in title')
def step(context):
    assert 'Beer Point' in context.page
