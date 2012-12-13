from nose.tools import with_setup

# http://stackoverflow.com/questions/10565523/how-can-i-access-variables-set-in-the-python-nosetests-setup-function
# A third variant might be to use a dictionary for your values. This is slightly less ugly but horribly clumsy:

_keeper = {'cache': 10}

def setup_func():
    "set up test fixtures"
    _keeper['cache'] = 5

def teardown_func():
    "tear down test fixtures"
    _keeper['cache'] = 10

@with_setup(setup_func, teardown_func)
def test_1():
    "change_name.test1 ..."
    assert _keeper['cache'] == 5

def test_2():
    assert _keeper['cache'] == 10
