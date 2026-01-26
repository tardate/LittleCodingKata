#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "prism"

# A visitor class with methods to print out
# class and def nodes.

class ClassDefPrinter < Prism::Visitor
  def visit_class_node(ast_node)
    puts "class #{ast_node.name}"
    super
  end

  def visit_def_node(ast_node)
    puts "def #{ast_node.name}"
    super
  end
end

# Read and parse the Ruby source.
src = File.read("document.rb")
ast = Prism::parse(src)

# Now run through the resulting AST, looking for
# classes and method definitions.
ast.value.accept(ClassDefPrinter.new)
