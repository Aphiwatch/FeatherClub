package models

type Subclass struct {
	ID            *int    `json:"id"`
	Name          *string `json:"name"`
	ParentClassID int     `json:"parent_class_id"`
}
