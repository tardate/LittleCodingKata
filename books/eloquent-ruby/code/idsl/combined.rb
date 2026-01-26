#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "rawk_1"

module Version1
  def self.run_combined_rawk
    rawk = Rawk.new do |r|
      r.on_path { |path| puts path }

      r.on_file("*.txt") do |path|
        puts "path: #{path}"
        open(path) { |f| puts f.readline }
      end

      r.transform("*.txt") do |contents|
        contents.gsub!(/Spacely Sprockets/, "Coswell Cogs")
      end
    end

    rawk.run("marketing")
  end
end


