#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
# Compile everyone's favorite program into byte codes.

source = %{puts "Hello world!"}
code = RubyVM::InstructionSequence.compile(source)

# And dump a textual representation of the byte codes.

pp code.to_a
