#!/usr/bin/env ruby

require 'json'

class Repairer
  attr_reader :input
  attr_reader :k
  attr_reader :logging

  def initialize(input, k, logging = false)
    @input = input
    @k = k
    @logging = logging
  end

  def log(message)
    puts message if logging
  end

  def extractRegions
    visited = Array.new(input.length) { Array.new(input[0].length, false) }
    result = []

    input.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next if visited[i][j] || cell == 1

        # BFS to find connected broken tiles
        region = []
        queue = [[i, j]]
        visited[i][j] = true

        while queue.any?
          ci, cj = queue.shift
          region << [ci, cj]

          [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |di, dj|
            ni, nj = ci + di, cj + dj
            next if ni < 0 || ni >= input.length || nj < 0 || nj >= input[0].length
            next if visited[ni][nj] || input[ni][nj] == 1

            visited[ni][nj] = true
            queue << [ni, nj]
          end
        end

        result << region if region.length > k
      end
    end
    result
  end

  def minRepairs
    result = 0
    loop do
      regions = extractRegions
      log "Broken regions: #{regions.inspect}"
      break if regions.empty?

      # in each region, find the cell with the most neighbors and "repair it" (delete it and inc result)
      # Find the cell with the most neighbors in any region
      regions.each_with_index do |region, idx|
        max_neighbors = 0
        cell_to_repair = nil

        region.each do |ci, cj|
          neighbors = 0
          [[0, 1], [0, -1], [1, 0], [-1, 0]].each do |di, dj|
            ni, nj = ci + di, cj + dj
            neighbors += 1 if region.include?([ni, nj])
          end
          if neighbors > max_neighbors
            max_neighbors = neighbors
            cell_to_repair = [ci, cj]
          end
        end
        if cell_to_repair
          input[cell_to_repair[0]][cell_to_repair[1]] = 1
          result += 1
          log "Repaired #{cell_to_repair}, repairs: #{result}"
        end
      end
    end

    result
  end
end

if __FILE__ == $PROGRAM_NAME
  (puts "Usage: ruby #{$0} <json-file> <k>"; exit) unless ARGV.length > 1
  json_file_name = ARGV[0]
  begin
    input = JSON.parse(File.read(json_file_name))
  rescue
    puts "Error: Invalid JSON file - #{json_file_name}"
    exit
  end
  k = ARGV[1].to_i
  calculator = Repairer.new(input, k, true)
  puts "Input array: #{calculator.input.inspect}"
  puts "k: #{calculator.k.inspect}"
  puts "Result: #{calculator.minRepairs}"
end
