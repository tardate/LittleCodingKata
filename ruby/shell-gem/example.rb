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
