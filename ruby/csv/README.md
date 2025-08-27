# #287 CSV with Ruby

All about reading and writing CSV with Ruby, including large file handling.

## Notes

CSV support is implemented in the [CSV](https://ruby-doc.org/3.0.6/stdlibs/csv/CSV.html) standard library.
There are some gems that provide additional CVS processing features, but in most cases the standard library is just fine.

## Writing Large Files

The [large_file_write.rb](./large_file_write.rb) example demonstrates 2 ways of writing large files:

* using `CSV.generate` to build a CSV data structure that is then written to file
* using `CSV.generate_line` to generate a file line-by-line

Using `CSV.generate`, results show a relatively large peak memory use:

    $ ./large_file_write.rb generate
    writing 2000000 rows using generate...
    Max memory usage: 91.15625Mb

Using `CSV.generate_line`, results show minimal peak memory use:

    $ ./large_file_write.rb generate_line
    writing 2000000 rows using generate_line...
    Max memory usage: 32.765625Mb

## Reading Large Files

The [large_file_read.rb](./large_file_read.rb) example demonstrates 2 ways of reading large files.

* using `CSV.read` to load the CSV file into memory for processing
* using `CSV.foreach` to process the CSV as an I/O stream, line-by-line.

Note: run [large_file_write.rb](./large_file_write.rb) first to generate the csv file to be read.

Using `CSV.read`, results show excessive memory usage:

    $ ./large_file_read.rb read
    reading using read...
    #<CSV::Row "col1":"row 1999999" "col2":"1999999">
    Max memory usage: 1493.1875Mb

Using `CSV.foreach`, results show minimal peak memory use:

    $ ./large_file_read.rb foreach
    reading using foreach...
    #<CSV::Row "col1":"row 1999999" "col2":"1999999">
    Max memory usage: 37.703125Mb

## Credits and References

* [stdlibs: CSV](https://ruby-doc.org/3.0.6/stdlibs/csv/CSV.html)
* [How To Read & Parse CSV Files With Ruby](https://www.rubyguides.com/2018/10/parse-csv-ruby/)
* [Parsing a CSV File in Ruby](https://medium.com/swlh/parsing-a-csv-file-in-ruby-6de8afd382c8)
* [get_process_mem](https://rubygems.org/gems/get_process_mem)
