#!/usr/bin/env python
from setuptools import find_packages, setup


setup(
    name="python3-boilerplate",
    version="0.0.1-SNAPSHOT",
    description="A boilerplate for creating python 3 projects and libraries.",
    url="https://github.com/alexbahnisch/python3-boilerplate",
    author="Alex Bahnisch",
    author_email="alexbahnisch@gmail.com",
    license="MIT",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.6"
    ],
    keywords="python boilerplate",
    packages=find_packages("src", exclude=["tests"]),
    package_dir={"": "src"},
    install_requires=[
        "future>=0.16.0"
    ],
    setup_requires=[
        "pytest-runner>=2.11.1",
        "tox>=2.7.0"
    ],
    tests_require=[
        "pytest>=3.1.3"
    ],
    test_suite="src.tests"
)
