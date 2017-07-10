#!/usr/bin/env python
from future.utils import raise_from, raise_with_traceback
from pytest import raises


class CustomException(Exception):
    pass


def raise_custom_exception():
    try:
        open("no file")
    except IOError as exception:
        raise_from(CustomException('failed to open'), exception)


def test_raise_with_traceback():
    """
    Raising exceptions with a traceback
    """
    with raises(ValueError) as exception:
        raise_with_traceback(ValueError("Bad Value"))
        assert "Bad Value" == str(exception.value)


def test_raise_from():
    """
    Exception chaining
    """
    with raises(CustomException) as exception:
        raise_custom_exception()
        assert isinstance(exception.__cause__, IOError)
