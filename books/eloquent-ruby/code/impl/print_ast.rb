#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "prism"

# The source we are going to parse.

src = <<~EOF
  if denominator != 0
    quotient = numerator / denominator 
  end
EOF

ast = Prism::parse(src)
pp(ast)
