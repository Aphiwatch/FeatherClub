package models

type Class struct {
	ID                *int    `json:"id"`
	Name              *string `json:"name"`
	ClassTranslations []ClassTranslation
}

type ClassTranslation struct {
	ID           int    `json:"id"`
	ClassID      int    `json:"class_id"`
	LanguageCode string `json:"language_code"`
	Name         string `json:"name"`
}
