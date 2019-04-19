#!/usr/bin/env make

## COLORS
RED := $(shell tput -Txterm setaf 1)
GREEN := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE := $(shell tput -Txterm setaf 7)
RESET := $(shell tput -Txterm sgr0)

## MACROS
ifneq (,$(filter $(shell uname -o),Msys MinGW))
MYPY := .venv/Scripts/mypy
PYTHON := python
PYTHON_VENV := .venv/Scripts/python
PIP_VENV := .venv/Scripts/pip
TOX := .venv/Scripts/tox
else
MYPY := .venv/bin/mypy
PYTHON := python3
PYTHON_VENV := .venv/bin/python
PIP_VENV := .venv/bin/pip
TOX := .venv/bin/tox
endif

TARGET_MAX_CHAR_NUM := 20

## HELPER TARGETS
.PHONY: default
default: help

.PHONY: help
## Show this message
help:
	@echo ''
	@echo 'Usage:'
	@echo '  $(YELLOW)make$(RESET) $(GREEN)<target>$(RESET)'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			split($$1, arr, ":"); \
			helpCommand = arr[1]; \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  $(YELLOW)%-$(TARGET_MAX_CHAR_NUM)s$(RESET) $(GREEN)%s$(RESET)\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## CACHEABLE TARGETS
# Create and cache a local virtual env
.venv:
	@$(PYTHON) -m venv .venv || $$(make clean && exit 1)
	@$(PYTHON_VENV) -m pip install --upgrade pip || $$(make clean && exit 1)

## TARGETS
.PHONY: clean
## Remove the virtual env and all auto generated directories/files
clean:
	@rm -rf .eggs .mypy_cache .pytest_cache .tox .venv build dist

.PHONY: install
## Install all dependencies
install: venv
	@$(PIP_VENV) install -e .[dev] || $$(rm -rf ./src/boilerplate.egg-info)
	@rm -rf ./src/boilerplate.egg-info

.PHONY: mypy
## Run mypy
mypy: venv
	@$(MYPY) ./scripts ./src ./tests

.PHONY: test
## Run tests
test:
	@$(PYTHON_VENV) setup.py test

.PHONY: tox
## Run tox tests
tox: venv
	@$(TOX)

.PHONY: venv
## Create a local virtual env
venv: .venv
	@echo '$(YELLOW)The virtual env (venv) has been cached, to delete the cache run "make clean" or delete the ".venv" directrory$(RESET)'
