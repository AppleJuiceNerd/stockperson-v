module main

fn test_read_csv() {
	// Test chapter 1 set
	for i in 1 .. 6 {
		do_ch1_set_test(i)
	}
}

fn do_ch1_set_test(set int) {
	mut data := [][]string{}
	match set {
		1 {
			data = read_csv('./data/chapter-1/stockperson-data-chapter1.0--set-01.csv')
			assert data.len == 68
		}
		2 {
			data = read_csv('./data/chapter-1/stockperson-data-chapter1.0--set-02.csv')
			assert data.len == 283
		}
		3 {
			data = read_csv('./data/chapter-1/stockperson-data-chapter1.0--set-03.csv')
			assert data.len == 1062
		}
		4 {
			data = read_csv('./data/chapter-1/stockperson-data-chapter1.0--set-04.csv')
			assert data.len == 5467
		}
		5 {
			data = read_csv('./data/chapter-1/stockperson-data-chapter1.0--set-05.csv')
			assert data.len == 11092
		}
		else {
			print("you shouldn't be here...")
		}
	}

	for line in data {
		assert line.len == 10
	}
}
