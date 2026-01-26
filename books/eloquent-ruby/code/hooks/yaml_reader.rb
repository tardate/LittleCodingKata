#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"
require_relative "document_reader"

require "yaml"

class YAMLReader < DocumentReader
  def self.can_read?(path)
    File.extname(path) == ".yml"
  end

  def initialize(path)
    @path = path
  end

  def read(path)
    data = YAML.load_file(path)
    title = data["title"]
    author = data["author"]
    content = data["content"]
  
    Document.new(title:, author:, content:)
   end
end
