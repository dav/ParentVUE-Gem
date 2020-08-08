SHELL := /usr/bin/env bash

.PHONY: lint

lint:
	bundle exec rubocop parentvue_script.rb lib specs

test:
	bundle exec rspec
