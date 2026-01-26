#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
# Simple model where publishers have many authors.

class Author < ApplicationRecord
  belongs_to :publisher
end

class Publisher < ApplicationRecord
  has_many :authors, dependent: :destroy
end


# Get a publisher. We'll just use the last one.
publisher = Publisher.last

# Has this publisher signed any authors yet?
# If not, then the authors array will match [].
if p in {authors: []}
  puts "#{p.name} has no authors!"
end

# Has the publisher signed exactly one author?
# If so then the authors array will match [sole_author],
# and the variable sole_author will get set.
if p in {authors: [sole_author]}
  puts "#{p.name} has signed #{sole_author.lname}!"
end

START:jane
# See if one of the publisher's authors has a first name
# of Jane. Remember that [*, something, *] will try to match
# something anywhere inside of an array.

if p in {authors: [*, {fname: "Jane"}, *]}
  puts "We found Jane!"
end
END:jane
=end
