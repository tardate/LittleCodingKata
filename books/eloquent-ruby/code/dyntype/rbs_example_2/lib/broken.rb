#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "document"

# Note: This file contains multiple problems!

# Make a new document with Author and Title instances.
# This will pass Sorbet type checking.
def correct_example
  author = Author.new(first_name: "Jane", last_name: "Austen")
  title = Title.new(main_title: "Emma", subtitle: "")
  doc = Document.new(author: author, title: title, content: "Emma Woodhouse, handsome...")
end

# Make a new document with string author and title.
# This will fail the Sorbet type checking.
def broken_example
  doc = Document.new(title: "Emma", author: "Austen", content: "Emma Woodhouse, handsome...")
  puts doc.description
end

broken_example
