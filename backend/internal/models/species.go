package models

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
