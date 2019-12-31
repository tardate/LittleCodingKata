#!/usr/bin/env ruby

def create_file_new(filename, content)
  puts "# creating file using File.new: #{filename}"
  f = File.new(filename, 'w')
  f.write(content)
  f.close
end

def create_file_open(filename, content)
  puts "# creating file using File.open: #{filename}"
  File.open(filename, 'w') do |file|
    file.write(content)
  end
end

def append_to_file(filename, content)
  puts "# appending to file: #{filename}"
  File.open(filename, 'a') do |file|
    file.write(content)
  end
end

def read_file(filename)
  puts "# reading file: #{filename}"
  File.read(filename)
end

def delete_file(filename)
  puts "# deleting file: #{filename}"
  File.delete(filename)
end

filename = 'example.txt'

create_file_new(filename, "Using File.new: Hello World!\n")
puts read_file(filename)
create_file_open(filename, "Using File.open: Hello World!\n")
puts read_file(filename)
append_to_file(filename, "Appended content to the file.\n")
puts read_file(filename)
delete_file(filename)
