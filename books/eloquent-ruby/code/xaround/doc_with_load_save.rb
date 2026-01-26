#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

class Document
  def self.load(path)
    open(path) do |f|
      puts("Loading #{path}")
      title = f.readline.strip
      author = f.readline.strip
      content = f.read
      Document.new(title:, author:, content:)
    end
  end

  def save(path)
    puts "Saving #{title} to #{path}."
    open(path, "w") do |f|
      f.puts(title)
      f.puts(author)
      f.print(content)
    end
    self
  end
end
