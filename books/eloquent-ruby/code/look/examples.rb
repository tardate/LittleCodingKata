#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

# Demo inline comments, good and bad.

def compute_total_energy(m, v, g, h)
  (0.5 * m * v**2) + (m * g * h)    # kinetic + potential
end

def increment(count)
    count += 1 # Add one to count
end


# Demo proper name formatting.

def count_words_in(the_string)
  the_words = the_string.split
  the_words.size
end

ANTLERS_PER_MALE_MOOSE = 2


# Exceptions to the general paren rules.

def puts_without_parens
  puts "Look Ma, no parentheses!"
end


class DocNoParens < Document
  # Yes!
  def words
    @content.split
  end 
end

class DocParens < Document
  # No!
  def words()
    @content.split()
  end
end

def if_with_parens(words)
    # Nope
    if (words.size < 100)
      puts "The document is not very long."
    end
end

def if_without_parens(words)
  # Yup
  if words.size < 100
    puts "The document is not very long."
  end
end


# Demo folding code into a single line.

def multiple_statements
  doc = Document.new(
          author: "Austen",
          title: "Emma",
          content: "Emma Woodhouse, handsome...")
    puts doc.title; puts doc.author
end

class DocumentException < Exception; end


def a_trivial_method; end

def another_trivial_method(title:, author:) end
#

def add_two(n) = n + 2 # Note the equals sign!


# Demo variations on blocks.

def brace_block
  10.times { |n| puts "The number is #{n}" }
end

def do_end_block
  10.times do |n| 
    puts "The number is #{n}"
    puts "Twice the number is #{n*2}"
  end
end

def do_end_words(doc)
  doc.words.each do |word| 
    puts word
  end
end

def braces_words(doc)
  doc.words.each { |word| puts word }
end

def some_very_very_very_very_long_expression(word)
  puts word
end

def block_with_long_expression(doc)
  doc.words.each { |word| some_very_very_very_very_long_expression(word) }
end


# Some exceptions to the paren rules.

def simple_is_a?(doc)
  puts doc.is_a? Document
end

# Nonsense class to make the example work.
class Verifier
  def verify(arg)
    return arg
  end
end

# Nonsense method to make the example work.
def filter_classes(arg)
  return arg
end

# Nonsense method to make the example work.
def get_document_class
  return Document
end

def complex_is_a?(doc)
  puts doc.is_a? Verifier.new.verify get_document_class
end

def better_complex_is_a?(doc)
  puts(doc.is_a?(Verifier.new.verify(get_document_class)))
end

# Some variations on the rules with Set and Float.

# The require is optional now.
require "set"

def make_a_set
  s1 = Set[1, 2]
end

def make_a_float
  pi = Float("3.14159")
end
