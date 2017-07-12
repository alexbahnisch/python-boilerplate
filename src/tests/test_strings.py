#!/usr/bin/env python
from __future__ import unicode_literals

from past.builtins import basestring

from .base import python3


def test_strings():
    assert "string" is u"string"
    assert "string" == u"string"
    assert "string" is not b"string"

    if python3():
        assert "string" != b"string"
    else:
        assert "string" == b"string"


def test_basestring():
    assert isinstance("string", basestring)
    assert isinstance(u"string", basestring)
    assert isinstance(b"string", basestring)
