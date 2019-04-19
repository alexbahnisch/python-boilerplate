#!/usr/bin/env python
from setuptools import find_packages, setup

install_requires = []

test_requires = [
    "pytest>=4.4.1,<5"
]

dev_requires = [
    *test_requires,
    "pytest-runner>=4.4.0,<5",
    "tox>=3.9.0,<4"
]

setup(
    name="boilerplate",
    version="0.0.1.dev0",
    description="A boilerplate for creating python 3 projects and libraries.",
    url="https://github.com/alexbahnisch/python-boilerplate",
    author="Alex Bahnisch",
    author_email="alexbahnisch@gmail.com",
    license="MIT",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Natural Language :: English",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 2.7"
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.5"
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: Implementation :: CPython"
    ],
    keywords="python boilerplate",
    packages=find_packages("src"),
    package_dir={"": "src"},
    python_requires=">=3.6",
    install_requires=install_requires,
    extras_require={
        "dev": dev_requires
    },
    tests_require=test_requires,
    test_suite="tests"
)
