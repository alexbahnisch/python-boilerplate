#!/usr/bin/env python
from future.utils import with_metaclass


class SuperClass(object):
    pass


class MetaClass(type):
    pass


class SubClass(with_metaclass(MetaClass, SuperClass)):
    pass


def test_meta():
    assert type(SubClass) is MetaClass
    assert not issubclass(SubClass, MetaClass)
    assert issubclass(SubClass, SuperClass)
