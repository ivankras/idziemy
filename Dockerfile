# Use the official Golang image as the base image
FROM golang:1.23.5-bookworm AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY go.mod go.sum ./

# Download the dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -o idziemy .

# Use a minimal base image for the final stage
FROM debian:bookworm-slim

# Set the working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/idziemy .

# Set the environment variable (default to "prod")
ENV APP_ENV=prod

# Expose the port the application will run on
EXPOSE 8080

# Command to run the application
CMD ["./idziemy"]
