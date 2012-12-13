@when('Looking at home page')
def step(context):
    context.browser.go(context.baseurl)

@then('We see lager beer')
def step(context):
    assert 'lager' in context.browser.get_html()

@then('We see Beer Point in title')
def step(context):
    assert 'Beer Point' in context.browser.get_title()
