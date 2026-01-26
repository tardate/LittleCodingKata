#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
def time_regex
  time_regex = /\d\d:\d\d (AM|PM)/
end

def time_match
  time_regex.match?("10:24 PM")
end

def non_match
  time_regex.match?("1X:24 NM")
end

def anywhere_match
  time_regex.match?("The time that this was written was 10:54 PM!")
end

def anywhere_match_flipped
  "The time that this was written was 10:54 PM!".match?(time_regex)
end

def case_insensitive_match
  "am".match?(/AM/i)
end
