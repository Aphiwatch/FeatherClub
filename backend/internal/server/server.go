package server

import (
	"backend/internal/routes"
	"log"

	"github.com/labstack/echo/v4"
)

func StartServer() {
	e := echo.New()

	// กำหนด route
	routes.RegisterRoutes(e)

	log.Println("Server is running on :8080")
	if err := e.Start(":8080"); err != nil {
		log.Fatal(err)
	}
}
