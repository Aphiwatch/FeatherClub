package models

type Genus struct {
	ID             *int    `json:"id"`
	Name           *string `json:"name"`
	ParentFamilyID int     `json:"parent_family_id"`
}
