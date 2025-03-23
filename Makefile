.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import os, webbrowser, sys

from urllib.request import pathname2url

webbrowser.open("docs/_build/html/index.html")
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"
OS_VERSION ?= noble

PWD := $(shell pwd)
ARCH := $(shell uname -m)
PROJECT := "osv-scanner"
help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

.PHONY: bootstrap
bootstrap:  ## bootstrap the development environment
	echo "Happy coding!"


.PHONY: package
package: ## Build package
	docker run \
	-v ${PWD}:/${PROJECT} \
	--name ${PROJECT}-builder \
	--rm \
	"twindb/omnibus-ubuntu:${OS_VERSION}-${ARCH}" \
	bash -l /${PROJECT}/omnibus-${PROJECT}/omnibus_build.sh


.PHONY: package-manual
package-manual: ## Start a docker container with Omnibus
	docker run \
	-it \
	-v ${PWD}:/${PROJECT} \
	-w "/${PROJECT}" \
	--name ${PROJECT}-builder \
	--rm \
	"twindb/omnibus-ubuntu:${OS_VERSION}-${ARCH}" \
	bash -l

.PHONY: install-infrahouse-repo
install-infrahouse-repo:
	# Install dependencies
	apt-get update
	apt-get install gpg lsb-release curl
	# Add a GPG public key to verify InfraHouse packages
	mkdir -p /etc/apt/cloud-init.gpg.d/
	curl  -fsSL https://release-$$(lsb_release -cs).infrahouse.com/DEB-GPG-KEY-release-$$(lsb_release -cs).infrahouse.com \
		| gpg --dearmor -o /etc/apt/cloud-init.gpg.d/infrahouse.gpg
	# Add the InfraHouse repository source
	echo "deb [signed-by=/etc/apt/cloud-init.gpg.d/infrahouse.gpg] https://release-$$(lsb_release -cs).infrahouse.com/ $$(lsb_release -cs) main" \
		> /etc/apt/sources.list.d/infrahouse.list
	apt-get update
