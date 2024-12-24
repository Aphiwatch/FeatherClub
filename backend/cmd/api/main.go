package main

import (
	"log"
	"net/http"

	"backend/internal/server"
)

func main() {
	r := server.SetupRouter()
	log.Fatal(http.ListenAndServe(":8080", r))
}
