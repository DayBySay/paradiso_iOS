PRD_BUNDLE?=$(shell which bundle)

all:

install:
	$(PRD_BUNDLE) install --path=vendor
	$(PRD_BUNDLE) exec pod install

settings:
	perl -pe 's/###(PRDS_.*?)###/$$ENV{$$1}/' paradiso_iOS/ConfigurationService.base.swift > paradiso_iOS/ConfigurationService.swift
