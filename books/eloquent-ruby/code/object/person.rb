#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# We don"t really use date here, just
# demo"ing the require *method*.

require "date" # A Call to a method


class Person
  attr_accessor :salary  # A method call
  attr_reader :name      # Another method call
  attr_writer :password  # And another

  # Rest of the class omitted...
end

class Person
  def initialize(salary:, name:, password:)
    @salary = salary
    @name = name
    @password = password
  end
end

