.PHONY: ci fmt fmt-check help lint precommit test type-check

.DEFAULT_GOAL := help

SRCS := ./src ./t
ALLOW := --allow-env --allow-read --allow-run --allow-write
TEST_FLAG := --unstable --import-map=./t/map.json

ci: fmt-check lint type-check test

fmt: ## Format code
	deno fmt ${SRCS}

fmt-check: ## Format check
	deno fmt --check ${SRCS}

help:
	@cat $(MAKEFILE_LIST) | \
	    perl -ne 'if(/^\w+.*##/){s/(.*):.*##\s*/sprintf("%-20s",$$1)/eg;print}'

lint: ## Lint code
	deno lint ${SRCS}

precommit: fmt

test: ## Test
	deno test --no-check ${TEST_FLAG} ${ALLOW} --jobs

type-check: ## Type check
	deno test --no-run ${TEST_FLAG} $$(find ${SRCS} -name '*.ts' -not -name '.deno')
