module main

struct Document {
	id       string
	date     string
	invoices []InvoiceLine
}

struct InvoiceLine {
	customer_id string
	total       string
	discount    string
	line        string
	product_id  string
	quantity    string
	price       string
	line_amount string
}
