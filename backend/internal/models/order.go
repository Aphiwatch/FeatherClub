package models

type Order struct {
	ID                         *int    `json:"id"`
	Name                       *string `json:"name"`
	ParentSubclassID           int     `json:"parent_subclass_id"`
	TaxonomicOrderTranslations []TaxonomicOrderTranslation
}

type TaxonomicOrderTranslation struct {
	ID               int    `json:"id"`
	TaxonomicOrderID int    `json:"taxonomic_order_id"`
	LanguageCode     string `json:"language_code"`
	Name             string `json:"name"`
}
