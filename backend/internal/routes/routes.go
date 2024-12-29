package routes

import (
	"backend/internal/class/aves/handler"
	"backend/internal/class/aves/repository"
	"backend/internal/class/aves/service"
	"backend/internal/database"
	"log"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func SetupRoutes(e *echo.Echo) {
	// เรียก InitDB ก่อนที่จะตั้งค่า routes
	db, err := database.ConnectDB() // เชื่อมต่อฐานข้อมูล
	if err != nil {
		log.Fatal("Database connection failed:", err) // ถ้าเชื่อมต่อฐานข้อมูลไม่สําเร็จ
	}

	speciesRepo := repository.NewSpeciesRepository(db)
	speciesService := service.NewSpeciesService(speciesRepo)
	speciesHandler := handler.NewSpeciesHandler(speciesService)

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.GET("/:lang/classes/aves/species", speciesHandler.GetAllSpecies)
	e.GET("/:lang/classes/aves/species/:common_name", speciesHandler.GetSpeciesByCommonName)
}
