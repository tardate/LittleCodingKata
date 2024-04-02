#! /usr/bin/env ruby
require 'pathname'
require 'csv'
require 'get_process_mem'

class CsvWriter
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

  def default_rows
    2_000_000
  end

  def headers
    %w[col1 col2]
  end

  def write!(style, rows)
    style ||= 'generate_line'
    rows ||= default_rows
    puts "writing #{rows} rows using #{style}..."

    case style
    when 'generate_line'
      File.open(csv_file, 'w') do |file|
        file.write CSV.generate_line(headers, **csv_generation_options)
        rows.to_i.times do |i|
          file.write CSV.generate_line(["row #{i}", i], **csv_generation_options)
          max_memory!
        end
      end
    when 'generate'
      output_string = CSV.generate(**csv_generation_options) do |csv|
        csv << headers
        rows.to_i.times do |i|
          csv << ["row #{i}", i]
          max_memory!
        end
      end
      File.open(csv_file, 'w') do |file|
        file.write output_string
      end
      max_memory!
    else
      puts 'unsupported style'
    end
    puts "Max memory usage: #{max_memory}Mb"
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} <style=(generate_line|generate)> <rows|2_000_000>"; exit) unless ARGV.length > 0
  CsvWriter.new.write! ARGV[0], ARGV[1]
end

