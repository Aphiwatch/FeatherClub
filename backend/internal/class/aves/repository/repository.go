package repository

import (
	"backend/internal/models"
	"database/sql"
	"fmt"
)

// SpeciesRepository handles species-related database operations
type SpeciesRepository struct {
	DB *sql.DB
}

// NewSpeciesRepository creates a new instance of SpeciesRepository
func NewSpeciesRepository(db *sql.DB) *SpeciesRepository {
	return &SpeciesRepository{DB: db}
}

// GetAllSpecies fetches all species and their translations for the given language
func (r *SpeciesRepository) GetAllSpecies(languageCode string) ([]models.Species, error) {
	query := `
		SELECT s.id, s.scientific_name, s.parent_genus_id, 
		       t.id, t.language_code, t.common_name, 
		       t.iucn_status, t.conservation_status, t.estimated_population, 
		       t.height, t.weight, t.lifespan, t.lifespan_in_wild, 
		       t.lifespan_in_zoo, t.habitat, t.diet, t.predators, 
		       t.breeding_season, t.breeding_location, t.egg_color, 
		       t.egg_shape, t.egg_size, t.eggs_per_chick, t.clutch_duration, 
		       t.chick_ready_to_sea
		FROM species s
		LEFT JOIN species_translations t ON s.id = t.species_id
		WHERE t.language_code = $1`
	rows, err := r.DB.Query(query, languageCode)
	if err != nil {
		return nil, fmt.Errorf("error fetching species: %v", err)
	}
	defer rows.Close()

	speciesMap := make(map[int]*models.Species)
	for rows.Next() {
		var s models.Species
		var t models.SpeciesTranslation
		err := rows.Scan(
			&s.ID, &s.ScientificName, &s.ParentGenusID,
			&t.ID, &t.LanguageCode, &t.CommonName,
			&t.IUCNStatus, &t.ConservationStatus, &t.EstimatedPopulation,
			&t.Height, &t.Weight, &t.Lifespan, &t.LifespanInWild,
			&t.LifespanInZoo, &t.Habitat, &t.Diet, &t.Predators,
			&t.BreedingSeason, &t.BreedingLocation, &t.EggColor,
			&t.EggShape, &t.EggSize, &t.EggsPerChick, &t.ClutchDuration,
			&t.ChickReadyToSea,
		)
		if err != nil {
			return nil, fmt.Errorf("error scanning species: %v", err)
		}

		// Check if species already exists in map
		if existing, ok := speciesMap[s.ID]; ok {
			existing.SpeciesTranslations = append(existing.SpeciesTranslations, t)
		} else {
			s.SpeciesTranslations = []models.SpeciesTranslation{t}
			speciesMap[s.ID] = &s
		}
	}

	var speciesList []models.Species
	for _, s := range speciesMap {
		speciesList = append(speciesList, *s)
	}

	return speciesList, nil
}

// GetSpeciesByCommonName fetches a species by its common name and language
func (r *SpeciesRepository) GetSpeciesByCommonName(languageCode, commonName string) (*models.Species, error) {
	query := `
		SELECT s.id, s.scientific_name, s.parent_genus_id, 
		       t.id, t.species_id, t.language_code, t.common_name, 
		       t.iucn_status, t.conservation_status, t.estimated_population, 
		       t.height, t.weight, t.lifespan, t.lifespan_in_wild, 
		       t.lifespan_in_zoo, t.habitat, t.diet, t.predators, 
		       t.breeding_season, t.breeding_location, t.egg_color, 
		       t.egg_shape, t.egg_size, t.eggs_per_chick, t.clutch_duration, 
		       t.chick_ready_to_sea
		FROM species s
		LEFT JOIN species_translations t ON s.id = t.species_id
		WHERE t.language_code = $1 AND t.common_name = $2`
	row := r.DB.QueryRow(query, languageCode, commonName)

	var s models.Species
	var t models.SpeciesTranslation
	err := row.Scan(
		&s.ID, &s.ScientificName, &s.ParentGenusID,
		&t.ID, &t.SpeciesID, &t.LanguageCode, &t.CommonName,
		&t.IUCNStatus, &t.ConservationStatus, &t.EstimatedPopulation,
		&t.Height, &t.Weight, &t.Lifespan, &t.LifespanInWild,
		&t.LifespanInZoo, &t.Habitat, &t.Diet, &t.Predators,
		&t.BreedingSeason, &t.BreedingLocation, &t.EggColor,
		&t.EggShape, &t.EggSize, &t.EggsPerChick, &t.ClutchDuration,
		&t.ChickReadyToSea,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, nil // Species not found
		}
		return nil, fmt.Errorf("error fetching species: %v", err)
	}

	s.SpeciesTranslations = []models.SpeciesTranslation{t}
	return &s, nil
}
