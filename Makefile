#!/usr/bin/env make

## COLORS
red := $(shell tput -Txterm setaf 1)
green := $(shell tput -Txterm setaf 2)
yellow := $(shell tput -Txterm setaf 3)
white := $(shell tput -Txterm setaf 7)
reset := $(shell tput -Txterm sgr0)

## MACROS
poetry := poetry
target_max_char_number := 20

## HELPER TARGETS
.PHONY: default
default: help

.PHONY: help
## Show this message
help:
	@echo ''
	@echo 'Usage:'
	@echo '  $(yellow)make$(reset) $(green)<target>$(reset)'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			split($$1, arr, ":"); \
			helpCommand = arr[1]; \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  $(yellow)%-$(target_max_char_number)s$(reset) $(green)%s$(reset)\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## CACHEABLE TARGETS
# Create venv and install dependencies with poerty
.venv:
	@$(poetry) install
	@$(poetry) update pip
	@rm -rf ./src/*.egg-info

## TARGETS
.PHONY: clean
## Remove the virtual env and all auto generated directories/files
clean:
	@rm -rf .eggs .mypy_cache .pytest_cache .tox .venv build dist pip-wheel-metadata

.PHONY: install
## Create venv and install dependencies with poerty
install: .venv
	@echo '$(YELLOW)The virtual env (venv) has been cached, to delete the cache run "make clean" or delete the ".venv" directrory$(RESET)'

.PHONY: mypy
## Run mypy
mypy: install
	@$(poetry) run mypy ./scripts ./src ./tests

.PHONY: test
## Run tests
test: install
	@$(poetry) run pytest

.PHONY: tox
## Run tox tests
tox: install
	@$(poetry) run tox
