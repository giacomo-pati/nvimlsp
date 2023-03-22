ifdef OS
	SHELL := pwsh.exe
else
	SHELL := pwsh
endif
.SHELLFLAGS := -Command
STRATUM_CLI_RELEASE_VERSION ?= v0.0.1

# Get source files, ignore vendor directory
# SRC_FILES := $(shell find . -type f -name '*.go' -not -path "./vendor/*")
SRC_FILES := @(Get-ChildItem -Recurse -Filter '*.go' | Where-Object { -not ($$_ -match ".*/vendor/.*") })

.DEFAULT_GOAL := help

.PHONY: help tidy lint build install upgrade-all unit-test clean

help:
	@(Select-String '^([a-zA-Z0-9_-]+):.*?## (.*$$)' $(MAKEFILE_LIST)).Matches | ForEach-Object { "`e[36m{0,-15}`e[0m {1}" -f $$_.Groups[1].Value, $$_.Groups[2].Value } | Sort-Object

tidy: ## Clean up Go modules by adding missing and removing unused modules
	go mod tidy

lint: ## Run linter on all Go code
	$(SRC_FILES) | ForEach-Object { golint $$_}

run: ## Run the CLI
	go run ./cmd/gk

build: ## Compile the CLI into current folder
	go build -o . ./cmd/gk

build-windows: ## Compile the CLI into temp folder _temp as windows binary
	$$Env:GOOS="windows"; $$Env:GOARCH="amd64"; go build -o . ./cmd/gk

install: ## Compile and install the CLI to $GOPATH/bin
	go install ./cmd/gk

upgrade-all: ## Upgrades packages to the latest
	go get -u -t ./...
	go mod tidy

unit-test: ## Run unit tests
	# go test -v -mod=vendor -tags=unit ./...
	go test -v -tags=unit ./...

clean: ## Clean binary artifacts
	rm *.exe
