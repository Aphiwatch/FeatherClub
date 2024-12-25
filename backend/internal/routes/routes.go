package routes

import (
	"backend/internal/species"

	"github.com/labstack/echo/v4"
)

func RegisterRoutes(e *echo.Echo) {
	e.GET("/penguins", species.GetAllSpecies)
}
