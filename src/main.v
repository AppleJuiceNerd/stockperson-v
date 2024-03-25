module main

import os
import encoding.csv

fn main() {
	docs := create_documents('./data/chapter-1/stockperson-data-chapter1.0--set-01.csv')

	print_documents(docs)
}

fn print_documents(documents []Document) {
	separator := '+----------------------------------------------------------------------------------+'
	//            | INVOICE#: QIjWQ7                               DATE:        2023-11-22           |
	//            | CUSTOMER: BOyUMON                              DISCOUNT%:   9.25                 |
	//            +----------------------------------------------------------------------------------+
	//            | #   | PRODUCT                     | QTY      | PRICE      | AMOUNT               |
	//            | 10    aF1KeUz                             580     78933.39  45781371.59605947560 |

	for document in documents {
		// Begin document
		println(separator)

		// Document details
		println('| INVOICE#: ${document.id}                               DATE:        ${document.date}         |')
		println('| CUSTOMER: ${document.invoices[0].customer_id}                                DISCOUNT%:   ${document.invoices[0].discount}             |')

		println(separator)

		println('| #   | PRODUCT                     | QTY      | PRICE      | AMOUNT               |')

		println(separator)

		for invoice in document.invoices {
			println('| ${invoice.line:-2}    ${invoice.product_id:-7}                             ${invoice.quantity:-3}     ${invoice.price:-8}  ${invoice.line_amount} |')
		}

		println(separator)
		println('\n')
	}
}

fn create_documents(path string) []Document {
	data := read_csv(path)

	mut first_line := true
	mut current_doc := ''
	mut current_date := ''
	mut invoice_buffer := []InvoiceLine{}
	mut documents := []Document{}

	for line in data {
		if first_line {
			current_doc = line[0]
			current_date = line[2]
		}

		if current_doc == line[0] || first_line {
			invoice_buffer << InvoiceLine{
				customer_id: line[1]
				total: line[3]
				discount: line[4]
				line: line[5]
				product_id: line[6]
				quantity: line[7]
				price: line[8]
				line_amount: line[9]
			}
		} else {
			documents << Document{
				id: current_doc
				date: current_date
				invoices: invoice_buffer
			}

			current_doc = line[0]
			current_date = line[2]
			invoice_buffer.clear()

			invoice_buffer << InvoiceLine{
				customer_id: line[1]
				total: line[3]
				discount: line[4]
				line: line[5]
				product_id: line[6]
				quantity: line[7]
				price: line[8]
				line_amount: line[9]
			}
		}
		first_line = false
	}

	return documents
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
