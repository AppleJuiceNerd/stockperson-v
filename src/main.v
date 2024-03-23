module main

import os
import encoding.csv

fn main() {
	create_documents('./data/chapter-1/stockperson-data-chapter1.0--set-01.csv')
}

fn create_documents(path string) {
	data := read_csv(path)
}

fn doc_id_in_doc_list(id string, list []Document) bool {
	for doc in list {
		if doc.id == id {
			return true
		}
	}
	return false
}

fn read_csv(path string) [][]string {
	file := os.read_file(path) or { panic(err) }
	mut data := [][]string{}
	mut parser := csv.new_reader(file)
	
	for {
		items := parser.read() or { break }
		data << items
	}

	return data
}

struct Document {
	id string
	invoices    []InvoiceLine
}

struct InvoiceLine {
	customer_id string
	date        string
	total       string
	discount    string
	line        string
	product_id  string
	quantity    string
	price       string
	line_amount string
}
