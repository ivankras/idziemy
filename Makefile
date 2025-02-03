# Default environment
APP_ENV ?= dev

# Go command to use
GO := go

# Target to run the server
run:
	@echo "Starting server in $(APP_ENV) mode..."
	APP_ENV=$(APP_ENV) $(GO) run main.go

# Target to build the application
build:
	@echo "Building the application..."
	$(GO) build -o myapp main.go

# Target to clean build artifacts
clean:
	@echo "Cleaning up..."
	rm -f myapp

# Target to run tests
test:
	@echo "Running tests..."
	$(GO) test ./...

.PHONY: run build clean test