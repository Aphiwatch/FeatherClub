package models

type Family struct {
	ID            *int    `json:"id"`
	Name          *string `json:"name"`
	ParentOrderID int     `json:"parent_order_id"`
}
