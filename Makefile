PRD_BUNDLE?=$(shell which bundle)

all:

install:
	$(PRD_BUNDLE) install --path=vendor
	$(PRD_BUNDLE) exec pod install
