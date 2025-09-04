# #xxx Shell Gem

Quick review of the shell gem for ruby.

## Notes

The [Shell](https://rubygems.org/gems/shell) gem  implements an idiomatic Ruby interface for common UNIX shell commands.
It makes it easier to do things such as connecting commands with pipes and redirecting output to files.

See also: [The Ruby Way](../the-ruby-way/) 14.3 The Shell Library.

Some of the commands supported:

* cat
* cd
* echo
* foreach
* pipes and redirection
* system
* tee

The `def_system_command` method may also be used to extend the supported command set.

### Example

See [example.rb](./example.rb) for a quick play with the library:

```ruby
#!/usr/bin/env ruby
require 'shell'

working_directory = './tmp'
test_file_1 = 'file1.txt'
test_file_2 = 'file2.txt'
test_file_3 = 'file3.txt'

Dir.mkdir(working_directory) unless Dir.exist?(working_directory)

sh = Shell.cd(working_directory)

puts "# creating #{working_directory}/#{test_file_1}:"
sh.echo('This is a test') > test_file_1
sh.cat(test_file_1) > STDOUT

puts "# creating #{working_directory}/#{test_file_2}:"
sh.echo('This is another test') > test_file_2
sh.cat(test_file_2) > STDOUT

puts "# concat to #{working_directory}/#{test_file_3}:"
sh.cat(test_file_1,  test_file_2) | sh.tee(test_file_3) > STDOUT

puts "# use `system` to invoke arbitrary commands e.g. `cat #{test_file_3}`:"
sh.transact do
  puts sh.system('cat', test_file_3)
end

puts "# define a system command `ls` and use it to show contents of #{working_directory}:"
Shell.def_system_command "ls"
puts sh.ls('-l')

puts "# use `foreach` to iterate through the contents of #{working_directory}:"
sh.foreach do |f|
  puts f
end
```

Sample run:

```sh
# creating ./tmp/file1.txt:
This is a test
# creating ./tmp/file2.txt:
This is another test
# concat to ./tmp/file3.txt:
This is a test
This is another test
# use `system` to invoke arbitrary commands e.g. `cat file3.txt`:
shell(#<Th:0x00000001006db298 run>): /bin/cat file3.txt
This is a test
This is another test
# define a system command `ls` and use it to show contents of ./tmp:
shell(#<Th:0x00000001006db298 run>): ls -l
total 24
-rw-r--r--@ 1 paulgallagher  staff  15 Sep  4 12:16 file1.txt
-rw-r--r--@ 1 paulgallagher  staff  21 Sep  4 12:16 file2.txt
-rw-r--r--@ 1 paulgallagher  staff  36 Sep  4 12:16 file3.txt
# use `foreach` to iterate through the contents of ./tmp:
.
..
file2.txt
file3.txt
file1.txt
```

## Credits and References

* <https://rubygems.org/gems/shell>
* <https://github.com/ruby/shell>
* [The Ruby Way](../the-ruby-way/) 14.3 The Shell Library
