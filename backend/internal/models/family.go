package models

type Family struct {
	ID                 *int    `json:"id"`
	Name               *string `json:"name"`
	ParentOrderID      int     `json:"parent_order_id"`
	FamilyTranslations []FamilyTranslation
}

type FamilyTranslation struct {
	ID           int    `json:"id"`
	FamilyID     int    `json:"family_id"`
	LanguageCode string `json:"language_code"`
	Name         string `json:"name"`
}
