#! /usr/bin/env ruby
require 'pathname'
require 'csv'
require 'get_process_mem'

class CsvReader
  attr_reader :max_memory

  def mem
    @mem ||= GetProcessMem.new
  end

  def max_memory!
    @max_memory = [@max_memory, mem.mb].compact.max
  end

  def base_folder
    Pathname.new(File.dirname(__FILE__))
  end

  def csv_file
    base_folder.join('tmp-large-file.csv')
  end

  def csv_generation_options
    { encoding: Encoding.find('UTF-8') }
  end

  def read!(style)
    style ||= 'foreach'
    last_row = nil
    puts "reading using #{style}..."
    case style
    when 'foreach'
      File.open(csv_file) do |file|
        CSV.foreach(file, headers: true) do |row|
          last_row = row
          max_memory!
        end
      end
    when 'read'
      CSV.read(csv_file, headers: true).each do |row|
        last_row = row
        max_memory!
      end
    else
      puts 'unsupported style'
    end
    p last_row
    puts "Max memory usage: #{max_memory}Mb"
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} <style=(foreach|read)>"; exit) unless ARGV.length==1
  CsvReader.new.read! ARGV[0]
end
