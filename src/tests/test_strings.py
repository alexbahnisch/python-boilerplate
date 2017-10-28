from __future__ import unicode_literals

from six import string_types, PY2, PY3


def test_strings():
    assert "string" is u"string"
    assert "string" == u"string"
    assert "string" is not b"string"

    if PY3:
        assert "string" != b"string"
    else:
        assert "string" == b"string"


def test_basestring():
    assert isinstance("string", string_types)
    assert isinstance(u"string", string_types)
    if PY2:
        assert isinstance(b"string", string_types)
