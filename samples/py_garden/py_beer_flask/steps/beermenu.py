@when('Looking at home page')
def step(context):
    context.page = context.client.get("/",follow_redirects=True)
    assert context.page

@then('We see lager beer')
def step(context):
    assert 'lager' in context.page.data

@then('We see Beer Point in title')
def step(context):
    assert '<title>Beer Point</title>' in context.page.data
