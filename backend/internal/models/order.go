package models

type Order struct {
	ID               *int    `json:"id"`
	Name             *string `json:"name"`
	ParentSubclassID int     `json:"parent_subclass_id"`
}
