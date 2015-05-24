#
# Makefile for all-i-want-ui
# Copyright (c) 2015 Adam Meadows. All rights reserved.
#

GITHUB_HOST := github.com
REPO := jobsquad/aiw-ui
PROJECT_NAME := aiw-ui

GHP_COPY_APP := \
	bundle.ghp-copy \
	package.json.ghp-copy \
	index.html.ghp-copy

# Uncomment these if you want to override the default Selenium configs
#SELENIUM_HOST ?= localhost
#SELENIUM_PORT ?= 4444
#SELENIUM_BROWSER ?= chrome

-include node_modules/beaker/make/common.mk
-include node_modules/beaker/make/gh-pages.mk
-include node_modules/beaker/make/karma-targets.mk
-include node_modules/beaker/make/e2e-targets.mk

.PHONY: install clean test coverage release ghp-update

# NOTE: install target will not have loaded the include above
# from beaker, so you don't have the ENV or SHELL variables set
# The karma-jasmine-jquery package doesn't do postinstall properly when a peer dep,
# So we do its postinstall step again at the end
install:
	$(HIDE)npm install
	$(HIDE)cd node_modules/karma-jasmine-jquery && node install.js

clean:
	$(HIDE)rm -rf bundle coverage

ci-test: lint karma-test karma-coverage karma-coveralls

test: karma-test

coverage: karma-coverage

karma-coveralls:
	$(ENV)cat coverage/lcov.info | coveralls

release: build
	$(HIDE)echo "Publishing version $(VERSION)"
	$(HIDE)npm publish .

ghp-update: build-mock ghp-clean ghp-checkout $(GHP_COPY_APP) ghp-publish
