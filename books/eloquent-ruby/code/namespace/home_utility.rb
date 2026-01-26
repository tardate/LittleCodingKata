#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module WordProcessor
  # A simple utility method to convert points to inches.
  def self.points_to_inches(points)
    points / 72.0
  end

  # ... so simple, in fact, we can write them as endless methods.
  def self.inches_to_points(inches) = inches * 72.0

  # Rest of the module omitted
end
