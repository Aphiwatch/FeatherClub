package handler

import (
	"backend/internal/class/aves/service"
	"net/http"

	"github.com/labstack/echo/v4"
)

type SpeciesHandler struct {
	Service *service.SpeciesService
}

func NewSpeciesHandler(service *service.SpeciesService) *SpeciesHandler {
	return &SpeciesHandler{Service: service}
}

func (h *SpeciesHandler) GetAllSpecies(c echo.Context) error {
	lang := c.Param("lang")
	species, err := h.Service.GetAllSpecies(lang)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{
			"error": "Failed to fetch species",
		})
	}
	return c.JSON(http.StatusOK, species)
}

func (h *SpeciesHandler) GetSpeciesByCommonName(c echo.Context) error {
	lang := c.Param("lang")
	commonName := c.Param("common_name")
	species, err := h.Service.GetSpeciesByCommonName(lang, commonName)
	if err != nil {
		return c.JSON(http.StatusNotFound, map[string]string{
			"error": "Species not found",
		})
	}
	return c.JSON(http.StatusOK, species)
}
