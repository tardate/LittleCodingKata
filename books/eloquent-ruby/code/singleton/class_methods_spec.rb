#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "../common/document"

class Document
  class << self
    def find_by_name(name:)
      # Find a document by name...
    end

    def find_by_id(id:)
      # Find a document by id
    end
  end
end

describe "a class method" do
  it "is the same as a singleton method" do
    expect do
      my_object = Document.new(
        title: 'War and Peace',
        author: 'Tolstoy',
        content:'All happy families...')

      def my_object.explain
        puts "self is #{self}"
        puts "and its class is #{self.class}"
      end

      my_object.explain
    end.to output(/self is #<Doc.* class is Document/m).to_stdout
  end

  it "is defined like a singleton method" do
    expect do
      my_object = Document

      def my_object.explain
        puts "self is #{self}"
        puts "and its class is #{self.class}"
      end

      my_object.explain
    end.to output(/self is Document.* class is Class/m).to_stdout

    expect do
      Document.explain
    end.to output(/self is Document/).to_stdout
  end

  it "can be defined explicitly" do
    expect do
      def Document.explain
        puts "self is #{self}"
        puts "and its class is #{self.class}"
      end

      Document.explain
    end.to output(/self is Document/).to_stdout
  end

  it "can be defined with the class << self syntax" do
    Document.find_by_name(name: "Memo")
    Document.find_by_id(id: 1234)
  end
end
