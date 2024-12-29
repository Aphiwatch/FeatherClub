package models

type Genus struct {
	ID                *int    `json:"id"`
	Name              *string `json:"name"`
	ParentFamilyID    int     `json:"parent_family_id"`
	GenusTranslations []GenusTranslation
}

type GenusTranslation struct {
	ID           int    `json:"id"`
	GenusID      int    `json:"genus_id"`
	LanguageCode string `json:"language_code"`
	Name         string `json:"name"`
}
