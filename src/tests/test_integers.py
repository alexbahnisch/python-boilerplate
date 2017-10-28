from six import integer_types


def test_int():
    assert isinstance(2, integer_types)


def test_long():
    assert isinstance(2 ** 32, integer_types)
