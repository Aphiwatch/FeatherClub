package models

type Subclass struct {
	ID                   *int    `json:"id"`
	Name                 *string `json:"name"`
	ParentClassID        int     `json:"parent_class_id"`
	SubclassTranslations []SubclassTranslation
}

type SubclassTranslation struct {
	ID           int    `json:"id"`
	SubclassID   int    `json:"subclass_id"`
	LanguageCode string `json:"language_code"`
	Name         string `json:"name"`
}
