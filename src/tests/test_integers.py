#!/usr/bin/env python
from builtins import int


def test_int():
    assert isinstance(2, int)


def test_long():
    assert isinstance(2 ** 32, int)
