package main

import (
	"encoding/json"
	"net/http"
	"os"
)

type HealthMessage struct {
	Message string `json:"message"`
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	// Set the content type to application/json
	w.Header().Set("Content-Type", "application/json")

	// Create a HealthMessage struct with an "okay" message
	msg := HealthMessage{Message: "Go Server OK"}

	// Encode the HealthMessage struct to JSON and write it to the response
	json.NewEncoder(w).Encode(msg)
}

func main() {
	// Register the healthHandler function to handle requests to the /health endpoint
	http.HandleFunc("/health", healthHandler)

	// Determine the environment (e.g., "dev" or "prod")
	env := os.Getenv("APP_ENV") // Set this environment variable before running the app
	// Set the listen address based on the environment
	addr := ":8080" // Default to all interfaces
	if env == "dev" {
		addr = "127.0.0.1:8080" // Bind to localhost in development
	}

	// Start the server
	println("Server is running on " + addr)
	http.ListenAndServe(addr, nil)
}
