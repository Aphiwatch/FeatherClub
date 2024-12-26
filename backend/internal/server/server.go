package server

import (
	"backend/internal/routes"

	"backend/internal/database"
	"fmt"

	"github.com/labstack/echo/v4"
)

func StartServer() {
	e := echo.New()

	// กำหนด route
	routes.SetupRoutes(e)

	db, err := database.ConnectDB()
	if err != nil {
		fmt.Println("Error connecting to database:", err)
		return
	}
	defer db.Close()

	e.Logger.Fatal(e.Start(":8080"))
}
