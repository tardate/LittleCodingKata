#! /usr/bin/env ruby
require 'optparse'
require 'id3taginator'

class ID3Tagger
  def options
    @options ||= parse_options
  end

  def filename
    @filename ||= ARGV.pop
  end

  def audio_file
    @audio_file ||= Id3Taginator.build_by_path(filename) if filename
  end

  def run
    if options.empty?
      puts "Error: No options specified."
      exit 1
    end

    if filename.nil? || !File.exist?(filename)
      puts "Error: Specified mp3 file does not exist."
      exit 1
    end

    case options[:action]
    when :update
      update_tags
    when :remove
      remove_tags
    when :create
      create_tags
    else
      show_tags
    end
  end

  private

  def parse_options
    result = {}
    OptionParser.new do |opts|
      opts.banner = "Usage: id3tagger.rb [options] file"

      opts.on("-s", "--show", "Show the ID3 tags") do
        result[:action] = :show
      end

      opts.on("-u", "--update", "Update the ID3 tags") do
        result[:action] = :update
      end

      opts.on("-r", "--remove", "Remove ID3 tags") do
        result[:action] = :remove
      end

      opts.on("-CVERSION", "--create VERSION", "Create ID3 tag VERSION=1 or 2") do |version|
        result[:action] = :create
        result[:version] = version
      end

      opts.on("-aARTIST", "--artist=ARTIST", "Specify the artists (v1: text, v2: CSV list)") do |artists|
        result[:artists] = artists
      end

      opts.on("-tTITLE", "--title=TITLE", "Specify the title") do |title|
        result[:title] = title
      end

      opts.on("-AALBUM", "--album=ALBUM", "Specify the album name") do |album|
        result[:album] = album
      end

      opts.on("-yYEAR", "--year=YEAR", "(v2 only) Specify the year") do |year|
        result[:year] = year
      end

      opts.on("-gGENRE", "--genre=GENRE", "(v2 only) Specify genres as CSV list") do |genres|
        result[:genres] = genres
      end

      opts.on("-cCOMMENT", "--comment=COMMENT", "(v2 only) Specify an English comment as '<descriptor>,<comment>'. If '<comment>' is blank, will remove comment for the descriptor") do |comments|
        result[:comments] = comments
      end
    end.parse!

    result
  end

  def show_tags
    if v1_tags = audio_file.id3v1_tag
      puts "Title: #{v1_tags.title || 'null'}"
      puts "Artist: #{v1_tags.artist || 'null'}"
      puts "Album: #{v1_tags.album || 'null'}"
    elsif v2_tags = audio_file.id3v2_tag
      puts "Title: #{v2_tags.title || 'null'}"
      puts "Album: #{v2_tags.album || 'null'}"
      puts "Year: #{v2_tags.year || 'null'}"
      puts "Artists:"
      Array(v2_tags.artists).each do |artist|
        puts " - #{artist}"
      end
      puts "Genres:"
      Array(v2_tags.genres).each do |genre|
        puts " - #{genre}"
      end
      puts "Comments:"
      Array(v2_tags.comments).each do |comment|
        puts " - #{comment.descriptor}: #{comment.text}"
      end
    else
      puts "No ID3 tags found."
    end
  end

  def update_tags
    if v1_tags = audio_file.id3v1_tag
      v1_tags.title = options[:title] if options[:title]
      v1_tags.artist = options[:artists] if options[:artists]
      v1_tags.album = options[:album] if options[:album]
      audio_file.write_audio_file(filename)
      puts "ID3v1 tags updated successfully."
    elsif v2_tags = audio_file.id3v2_tag
      v2_tags.title = options[:title] if options[:title]
      v2_tags.year = options[:year] if options[:year]
      v2_tags.album = options[:album] if options[:album]
      v2_tags.artists = options[:artists].split(',') if options[:artists]
      v2_tags.genres = options[:genres].split(',') if options[:genres]
      if options[:comments]
        descriptor, comment = options[:comments].split(',')
        if comment
          v2_tags.add_comment(Id3Taginator.create_comment('eng', descriptor, comment))
        else
          v2_tags.remove_comment('eng', descriptor)
        end
      end
      audio_file.write_audio_file(filename)
      puts "ID3v2 tags updated successfully."
    else
      puts "No ID3 tags found."
    end
  end

  def remove_tags
    audio_file.remove_id3v1_tag
    audio_file.remove_id3v2_tag
    audio_file.write_audio_file(filename)
    puts "Removed all ID3 tags."
  end

  def create_tags
    if options[:version] == "1"
      version = "1"
      audio_file.create_id3v1_tag
    else
      version = "2.3"
      audio_file.create_id3v2_3_tag
    end
    audio_file.write_audio_file(filename)
    puts "Created ID3 tags version #{version}."
  end
end

ID3Tagger.new.run
