#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

def basic_case(title)
  case title
  when "War And Peace"
    puts "Tolstoy"
  when "Romeo And Juliet"
    puts "Shakespeare"
  else
    puts "Don't know"
  end
end

def value_returned(title)
  author =
    case title
    when "War And Peace"
      "Tolstoy"
    when "Romeo And Juliet"
      "Shakespeare"
    else
      "Don't know"
    end
end

def more_compact(title)
  author =
    case title
    when "War And Peace" then "Tolstoy"
    when "Romeo And Juliet" then  "Shakespeare"
    else "Don't know"
    end
end

def nil_no_match(title)
  author =
    case title
    when "War And Peace" then "Tolstoy"
    when "Romeo And Juliet" then  "Shakespeare"
    end
end

def case_classes(doc)
  case doc
  when Document
    puts "It's a document!"
  when String
    puts "It's a string!"
  else
    puts "Don't know what it is!"
  end
end

def case_re(title)
  puts "case re title: [#{title}]"
  puts title =~ /War And .*/
  case title
  when /War And .*/
    puts "Maybe Tolstoy?"
  when /Romeo And .*/
    puts "Maybe Shakespeare?"
  else
    puts "Absolutely no idea..."
  end
end

def case_conditions(title)
  case
  when title == "War And Peace"
    puts "Tolstoy"
  when title == "Romeo And Juliet"
    puts "Shakespeare"
  else
    puts "Absolutely no idea..."
  end
end
