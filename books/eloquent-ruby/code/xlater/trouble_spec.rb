#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_listeners"


def use_a_big_array
  # For some reason we need this array.
  big_array = Array.new(10_000_000)

  # Do something with big array...

  # big_array goes out of scode when method exits.
  nil
end


def add_load_listener_opps(doc)
  # For some reason we need this array.
  big_array = Array.new(10_000_000)

  # Do something with big array

  doc.on_load do |d|
    puts "big_array is defined in here!"
  end

  doc
end


def add_load_listener_better(doc)
  big_array = Array.new(10_000_000)

  # Do something with big array

  # And then get rid of it!
  big_array = nil

  doc.on_load do |d|
    puts "big_array is defined, but it's nil."
  end
end

module BlockListeners
  describe :use_a_big_array do
    it "works" do
      expect(use_a_big_array()).to be_nil
    end
  end

  describe :add_load_listener_opps do
    it "holds onto a reference to the big array" do
      doc = Document.new(author: "russ", title: "test", content: "text")
      add_load_listener_opps(doc)

      listener = doc.instance_variable_get(:@load_listener)
      big_array = listener.binding.local_variable_get(:big_array)
      expect(big_array.length).to eq(10_000_000)
    end
  end

  describe :add_load_listener_better do
    it "holds onto a reference to local variables" do
      doc = Document.new(author: "russ", title: "test", content: "text")
      add_load_listener_better(doc)

      listener = doc.instance_variable_get(:@load_listener)
      big_array = listener.binding.local_variable_get(:big_array)
      expect(big_array).to be nil
    end
  end
end
