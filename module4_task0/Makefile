go-build: ## Generates the API binary from golang files
	@docker run --volume=$(shell pwd):/app --workdir=/app golang:latest go build

hugo-build: ## Generates the static site using go hugo
	@hugo

build: ## Generate the website from the markdown and configuration files in the directory dist/ and compile the source code of the application to a binary named awesome-api
	-@make check
	-@make lint
	@make go-build
	@make hugo-build

clean: ## Cleanup the content of the directory dist/, the binary awesome-api and the log file awesome-api.log
	-@make stop
	-@rm -rf ./dist
	-@rm ./awesome-api ./awesome-api.log ./coverage-units.out 

post: ## Create a new blog post whose filename and title come from the environment variables POST_TITLE and POST_NAME.
	@hugo new posts/${POST_NAME}.md
	@sed -i 's/^title:.*/title: ${POST_TITLE}/g' ./content/posts/${POST_NAME}.md

run: ## Run the application in background by executing the binary awesome-api, and write logs into a file named awesome-api.log
	@make build
	@./awesome-api >./awesome-api.log 2>&1 &

stop: ## Stop the application with the command kill XXXXX where XXXXX is the Process ID of the application. 
	@kill "$(shell pgrep awesome-api)"

test: ## Check expected behaviour of the app
	@make unit-tests
	@make integration-tests
	@make validate

lint: ## Static linting on go files using golangci-lint
	@markdownlint README.md DEPLOY.md

unit-tests: ## execute (successfully) the Golang unit tests
	@docker run --volume=$(shell pwd):/app --workdir=/app golang:latest go test -v -short -coverprofile=coverage-units.out

integration-tests: ## execute the Golang integration tests
	@docker run --volume=$(shell pwd):/app --workdir=/app golang:latest go test -v -coverprofile=coverage-integrations.out

check: ## Markdown linting on syntax and dead links
	@markdown-link-check ./content/posts/*
	@markdownlint ./content/posts/*

validate: ## should validate the file ./dist/index.html by using the command line Holberton’s W3C Validator
	@-w3c_validator.py ./dist/index.html

package: ## Creates a zip file that contains lis needed files to deply the website
	@make build
	@zip awesome-website.zip awesome-api ./dist/

help: ## Shows this help message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'