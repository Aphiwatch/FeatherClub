package species

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

type Species struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	Location    string `json:"location"`
}

// Mock Data
var mockSpecies = []Species{
	{"Emperor Penguin", "The largest penguin species", "Antarctica"},
	{"King Penguin", "Second largest species", "Sub-Antarctic islands"},
}

// Handler สำหรับ GET /penguins
func GetAllSpecies(c echo.Context) error {
	return c.JSON(http.StatusOK, mockSpecies)
}
