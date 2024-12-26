package routes

import (
	"backend/internal/database"
	"backend/internal/species"
	"log"

	"github.com/labstack/echo/v4"
)

func SetupRoutes(e *echo.Echo) {
	// เรียก InitDB ก่อนที่จะตั้งค่า routes
	db, err := database.ConnectDB() // เชื่อมต่อฐานข้อมูล
	if err != nil {
		log.Fatal("Database connection failed:", err)
	}

	// เชื่อมต่อฐานข้อมูลกับ species
	species.InitDB(db)

	// ตั้งค่า routes สำหรับ species
	e.GET("/species", species.GetAllSpecies)
	e.GET("/species/:id", species.GetSpecies)
}
