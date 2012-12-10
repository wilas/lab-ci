def test_assert():
    assert 'soup' == 'soup'

def test_pass():
    pass

def test_fail():
    assert False

test_fail.will_fail = True
