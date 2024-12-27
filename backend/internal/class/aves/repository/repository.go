package repository

import (
	"backend/internal/models"
	"context"
	"database/sql"
	"errors"
)

type AvesRepository interface {
	GetAllSpecies() ([]models.Species, error)
	FindByCommonName(CommonName string) (*models.Species, error)
}

type avesRepositoryImpl struct {
	db *sql.DB
}

func NewAvesRepository(db *sql.DB) AvesRepository {
	return &avesRepositoryImpl{db: db}
}

// GetAllSpecies ดึงข้อมูลทั้งหมดจากฐานข้อมูล
func (r *avesRepositoryImpl) GetAllSpecies() ([]models.Species, error) {
	var species []models.Species

	rows, err := r.db.Query(`SELECT id, scientific_name, common_name, iucn_status, conservation_status, 
	estimated_population, height, weight, lifespan, lifespan_in_wild, lifespan_in_zoo, habitat, diet, 
	predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, eggs_per_chick, 
	clutch_duration, chick_ready_to_sea, parent_genus_id FROM species`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	for rows.Next() {
		var s models.Species
		// Scan data into the struct, using pointers for nullable fields
		err := rows.Scan(
			&s.ID,
			&s.ScientificName,
			&s.CommonName,
			&s.IUCNStatus,
			&s.ConservationStatus,
			&s.EstimatedPopulation,
			&s.Height,
			&s.Weight,
			&s.Lifespan,
			&s.LifespanInWild,
			&s.LifespanInZoo,
			&s.Habitat,
			&s.Diet,
			&s.Predators,
			&s.BreedingSeason,
			&s.BreedingLocation,
			&s.EggColor,
			&s.EggShape,
			&s.EggSize,
			&s.EggsPerChick,
			&s.ClutchDuration,
			&s.ChickReadyToSea,
			&s.ParentGenusID,
		)
		if err != nil {
			return nil, err
		}
		species = append(species, s)
	}

	return species, nil

}

func (r *avesRepositoryImpl) FindByCommonName(commonName string) (*models.Species, error) {
	query := `
		SELECT id, scientific_name, common_name, iucn_status, conservation_status, estimated_population, height, weight, lifespan, lifespan_in_wild, lifespan_in_zoo, habitat, diet, predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, eggs_per_chick, clutch_duration, chick_ready_to_sea, parent_genus_id
		FROM species
		WHERE common_name = $1
	`
	row := r.db.QueryRowContext(context.Background(), query, commonName)

	var species models.Species
	err := row.Scan(
		&species.ID,
		&species.ScientificName,
		&species.CommonName,
		&species.IUCNStatus,
		&species.ConservationStatus,
		&species.EstimatedPopulation,
		&species.Height,
		&species.Weight,
		&species.Lifespan,
		&species.LifespanInWild,
		&species.LifespanInZoo,
		&species.Habitat,
		&species.Diet,
		&species.Predators,
		&species.BreedingSeason,
		&species.BreedingLocation,
		&species.EggColor,
		&species.EggShape,
		&species.EggSize,
		&species.EggsPerChick,
		&species.ClutchDuration,
		&species.ChickReadyToSea,
		&species.ParentGenusID,
	)

	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, nil
		}
		return nil, err
	}

	return &species, nil
}
