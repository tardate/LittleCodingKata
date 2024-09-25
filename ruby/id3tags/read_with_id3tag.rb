#! /usr/bin/env ruby
require 'id3tag'

class ID3Tagger
  def filename
    @filename ||= ARGV.pop
  end

  def mp3_file
    @mp3_file ||= File.open(filename, 'rb') if filename
  end

  def file_tags
    @file_tags ||= ID3Tag.read(mp3_file) if mp3_file
  end

  def run
    if filename.nil? || !File.exist?(filename)
      puts "Error: Specified mp3 file does not exist."
      exit 1
    end

    show_tags
  end

  private

  def show_tags
    if file_tags
      puts "Filename: #{filename}"
      puts "Title: #{file_tags.title || 'null'}"
      puts "Artist: #{file_tags.artist || 'null'}"
      puts "Album: #{file_tags.album || 'null'}"
    else
      puts "No ID3 tags found."
    end
  end
end

ID3Tagger.new.run
