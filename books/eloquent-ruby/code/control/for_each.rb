#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
def for_fonts
  fonts = [ "courier", "times roman", "helvetica" ]

  for font in fonts
    puts font
  end
end

def fonts_each
  fonts = [ "courier", "times roman", "helvetica" ]

  fonts.each do |font|
    puts font
  end
end
