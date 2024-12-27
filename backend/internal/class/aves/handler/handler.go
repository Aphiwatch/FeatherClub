package handler

import (
	"backend/internal/class/aves/service"
	"net/http"

	"github.com/labstack/echo/v4"
)

type AvesHandler struct {
	service *service.AvesService
}

func NewAvesHandler(service *service.AvesService) *AvesHandler {
	return &AvesHandler{service: service}
}

// GetAllSpecies ใช้แสดงรายชื่อสายพันธุ์ทั้งหมด
func (h *AvesHandler) GetAllSpecies(c echo.Context) error {
	species, err := h.service.GetAllSpecies()
	if err != nil {
		return c.JSON(http.StatusInternalServerError, "Error retrieving species")
	}
	return c.JSON(http.StatusOK, species)
}

// GetSpeciesByCommonName ใช้แสดงข้อมูลของ species จากชื่อสามัญ
func (h *AvesHandler) GetSpeciesByCommonName(c echo.Context) error {
	commonName := c.Param("commonName")
	species, err := h.service.GetSpeciesByCommonName(commonName)
	if err != nil {
		return c.JSON(http.StatusNotFound, "Species not found")
	}
	return c.JSON(http.StatusOK, species)
}
