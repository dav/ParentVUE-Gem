SHELL := /usr/bin/env bash

.PHONY: lint

lint:
	bundle exec rubocop bin lib specs

test:
	bundle exec rspec

build:
	gem build parentvue.gemspec

uninstall:
	gem uninstall parentvue

install:
	gem install ./parentvue-0.1.0.gem

reinstall: uninstall build install


