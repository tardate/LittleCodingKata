#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document.rb"

class PrintableDocument < Document
  attr_accessor :pages_printed, :page_count

  def initialize(...)
    super
    @page_count = 5
    @pages_printed = 0
  end

  def start_printing
    @pages_printed = 0
  end

  def is_printed?
    @pages_printed >= @page_count
  end

  def print_next_page
    @pages_printed += 1
  end
end

def print_doc_with_while(document)
  document.start_printing
  while !document.is_printed?
    document.print_next_page
  end
end

def print_doc_with_until(document)
  document.start_printing
  until document.is_printed?
    document.print_next_page
  end
end

def print_doc_with_while_modifier(document)
  document.start_printing
  document.print_next_page while !document.is_printed?
end

def print_doc_with_until_modifier(document)
  document.start_printing
  document.print_next_page until document.is_printed?
end
