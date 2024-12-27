package service

import (
	"backend/internal/class/aves/repository"
	"backend/internal/models"
)

type AvesService struct {
	repo repository.AvesRepository
}

func (s *AvesService) GetAllSpecies() ([]models.Species, error) {
	return s.repo.GetAllSpecies()
}

func NewAvesService(repo repository.AvesRepository) *AvesService {
	return &AvesService{repo: repo}
}

func (s *AvesService) GetSpeciesByCommonName(commonName string) (*models.Species, error) {
	return s.repo.FindByCommonName(commonName)
}
