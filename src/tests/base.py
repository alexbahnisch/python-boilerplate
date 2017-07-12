#!/usr/bin/env python
from sys import version

from package import fun


def python3():
    return version >= u"3.0.0"
