package service

import (
	"backend/internal/class/aves/repository"
	"backend/internal/models"
)

// SpeciesService handles species-related business logic
type SpeciesService struct {
	repo *repository.SpeciesRepository
}

// NewSpeciesService creates a new instance of SpeciesService
func NewSpeciesService(repo *repository.SpeciesRepository) *SpeciesService {
	return &SpeciesService{repo: repo}
}

// GetAllSpecies retrieves all species for a specific language
func (s *SpeciesService) GetAllSpecies(languageCode string) ([]models.Species, error) {
	return s.repo.GetAllSpecies(languageCode)
}

// GetSpeciesByCommonName retrieves a species by its common name and language
func (s *SpeciesService) GetSpeciesByCommonName(languageCode, commonName string) (*models.Species, error) {
	return s.repo.GetSpeciesByCommonName(languageCode, commonName)
}
