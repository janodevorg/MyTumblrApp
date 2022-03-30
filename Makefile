#!/bin/bash -e -o pipefail

PROJECT_NAME = MyTumblrApp
TARGET_NAME = MyTumblrApp
TARGET_NAME_LOWERCASE = $(shell echo ${TARGET_NAME} | tr '[:upper:]' '[:lower:]')
GITHUB_USER = janodevorg

.PHONY: clean help project requirebrew requirexcodegen resetgit swiftdoc swiftlint test xcodegen

help: requirebrew requirexcodegen 
	@echo Usage:
	@echo ""
	@echo "  make clean       - removes all generated products"
	@echo "  make doccapp     - Generate documentation for UIKit project"
	@echo "  make project     - generates a xcode project with local dependencies"
	@echo "  make projecttest - Run tests using xcodebuild and a generated project"
	@echo "  make removecache - Remove Derived Data and SPM cache"
	@echo "  make swiftlint   - Run swiftlint"
	@echo ""

clean:
	rm -rf .build
	rm -rf .swiftpm
	rm -rf build
	rm -rf docs
	rm -rf Package.resolved

doccapp: requirejq
	rm -rf docs
	mkdir -p docs
	xcodebuild build -scheme ${TARGET_NAME} -destination generic/platform=iOS -allowProvisioningUpdates
	DOCC_JSON_PRETTYPRINT=YES
	xcodebuild docbuild \
		-scheme ${TARGET_NAME} \
		-destination generic/platform=iOS \
		OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path ${TARGET_NAME} --output-path docs"
	@echo "Check https://${GITHUB_USER}.github.io/${TARGET_NAME}/documentation/${TARGET_NAME_LOWERCASE}/"
	@echo ""

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

project: requirexcodegen
	rm -rf "${PROJECT_NAME}.xcodeproj"; \
	xcodegen generate --project . --spec project.yml; \
	echo Generated ${PROJECT_NAME}.xcodeproj

projecttest: project
	@echo Project name is ${PROJECT_NAME}
	xcodebuild test -project ${PROJECT_NAME}.xcodeproj -scheme ${PROJECT_NAME} -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 13,OS=latest' CODE_SIGN_IDENTITY= CODE_SIGNING_REQUIRED=NO

requirebrew:
	@if ! command -v brew &> /dev/null; then echo "Please install brew from https://brew.sh/"; exit 1; fi

requirejq:
	@if ! command -v jq &> /dev/null; then echo "Please install jq using 'brew install jq'"; exit 1; fi

requirexcodegen: requirebrew
	@if ! command -v xcodegen &> /dev/null; then echo "Please install xcodegen using 'brew install xcodegen'"; exit 1; fi

resetgit:
	# @echo "This removes Git history, including tags. Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	DIR=$(shell cd -P -- '$(shell dirname -- "$0")' && pwd -P | sed 's:.*/::'); \
	rm -rf .git; \
	git init; \
	git add .; \
	git commit -m "Initial"; \
	git remote add origin git@github.com:${GITHUB_USER}/$$DIR.git; \
	git push --force --set-upstream origin main; \
	git tag -d `git tag | grep -E '.'`; \
	git ls-remote --tags origin | awk '/^(.*)(s+)(.*[a-zA-Z0-9])$$/ {print ":" $$2}' | xargs git push origin; \
	git tag 1.0.0; \
	git push origin main --tags

removecache:
	rm -rf ~/Library/Caches/org.swift.swiftpm/
	rm -rf ~/Library/Developer/Xcode/DerivedData/**

swiftlint:
	swift run swiftlint
