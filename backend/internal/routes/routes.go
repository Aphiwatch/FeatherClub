package routes

import (
	"backend/internal/class/aves/handler"
	"backend/internal/class/aves/repository"
	"backend/internal/class/aves/service"
	"backend/internal/database"
	"log"

	"github.com/labstack/echo/v4"
)

func SetupRoutes(e *echo.Echo) {
	// เรียก InitDB ก่อนที่จะตั้งค่า routes
	db, err := database.ConnectDB() // เชื่อมต่อฐานข้อมูล
	if err != nil {
		log.Fatal("Database connection failed:", err) // ถ้าเชื่อมต่อฐานข้อมูลไม่สําเร็จ
	}

	// สร้าง Repository, handler และ Service สำหรับ Aves
	avesRepo := repository.NewAvesRepository(db)
	avesService := service.NewAvesService(avesRepo)
	avesHandler := handler.NewAvesHandler(avesService)

	// ตั้งค่า routes
	e.GET("/api/v1/classes/aves/species", avesHandler.GetAllSpecies)                      // all species in table species
	e.GET("/api/v1/classes/aves/species/:commonName", avesHandler.GetSpeciesByCommonName) // species by common name
}
