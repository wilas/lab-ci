from behave import *

@given('we have simple test')
def step(context):
    context.accept = 1

@when('test is run')
def step(context):
    pass

@then('test pass')
def step(context):
    assert context.accept

# And
@then('everyone is happy')
def step(context):
    pass

# But
@given('I want see test fail')
def step(context):
    context.accept = 0

@then('test fail')
def step(context):
    assert context.accept == 0
