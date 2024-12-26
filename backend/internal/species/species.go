package species

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/labstack/echo/v4"
)

type Species struct {
	ID                  int     `json:"id"`
	ScientificName      string  `json:"scientific_name"`
	CommonName          *string `json:"common_name,omitempty"`
	IUCNStatus          *string `json:"iucn_status,omitempty"`
	ConservationStatus  *string `json:"conservation_status,omitempty"`
	EstimatedPopulation *string `json:"estimated_population,omitempty"`
	Height              *string `json:"height,omitempty"`
	Weight              *string `json:"weight,omitempty"`
	Lifespan            *string `json:"lifespan,omitempty"`
	LifespanInWild      *string `json:"lifespan_in_wild,omitempty"`
	LifespanInZoo       *string `json:"lifespan_in_zoo,omitempty"`
	Habitat             *string `json:"habitat,omitempty"`
	Diet                *string `json:"diet,omitempty"`
	Predators           *string `json:"predators,omitempty"`
	BreedingSeason      *string `json:"breeding_season,omitempty"`
	BreedingLocation    *string `json:"breeding_location,omitempty"`
	EggColor            *string `json:"egg_color,omitempty"`
	EggShape            *string `json:"egg_shape,omitempty"`
	EggSize             *string `json:"egg_size,omitempty"`
	EggsPerChick        *int64  `json:"eggs_per_chick,omitempty"`
	ClutchDuration      *string `json:"clutch_duration,omitempty"`
	ChickReadyToSea     *string `json:"chick_ready_to_sea,omitempty"`
	ParentGenusID       int     `json:"parent_genus_id"`
}

var db *sql.DB

func InitDB(database *sql.DB) {
	if database == nil {
		log.Fatal("Database connection incomplete in species table")
	}
	db = database
}

// GetAllSpecies fetches all species from the database
func GetAllSpecies(c echo.Context) error {
	rows, err := db.Query(`SELECT id, scientific_name, common_name, iucn_status, conservation_status, 
	estimated_population, height, weight, lifespan, lifespan_in_wild, lifespan_in_zoo, habitat, diet, 
	predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, eggs_per_chick, 
	clutch_duration, chick_ready_to_sea, parent_genus_id FROM species`)

	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
	}
	defer rows.Close()

	var speciesList []Species
	for rows.Next() {
		var s Species
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
			&s.EggsPerChick, // This field is now sql.NullInt64
			&s.ClutchDuration,
			&s.ChickReadyToSea,
			&s.ParentGenusID,
		)
		if err != nil {
			return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
		}
		speciesList = append(speciesList, s)
	}

	if err := rows.Err(); err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
	}

	return c.JSON(http.StatusOK, speciesList)
}

// GetSpecies fetches a species by ID
func GetSpecies(c echo.Context) error {
	id := c.Param("id")
	query := `SELECT id, scientific_name, common_name, iucn_status, conservation_status, 
	estimated_population, height, weight, lifespan, lifespan_in_wild, lifespan_in_zoo, habitat, diet, 
	predators, breeding_season, breeding_location, egg_color, egg_shape, egg_size, eggs_per_chick, 
	clutch_duration, chick_ready_to_sea, parent_genus_id FROM species WHERE id = $1`

	var s Species
	err := db.QueryRow(query, id).Scan(
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
		&s.EggsPerChick, // This field is now sql.NullInt64
		&s.ClutchDuration,
		&s.ChickReadyToSea,
		&s.ParentGenusID,
	)

	if err == sql.ErrNoRows {
		return echo.NewHTTPError(http.StatusNotFound, "Species not found")
	}
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, err.Error())
	}

	return c.JSON(http.StatusOK, s)
}
