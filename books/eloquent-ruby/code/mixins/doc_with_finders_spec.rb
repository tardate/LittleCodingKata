#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_with_finders"

RSpec.shared_examples "a class with the class methods we expect" do
  it "has the module methods" do
    subject.method(:find_by_name)
    subject.method(:find_by_id)
  end
end

module ClassInclude
  RSpec.describe ClassInclude::Document do
    subject { Document }
    it_behaves_like "a class with the class methods we expect"

    it "lets you search by name" do
      war_and_peace = Document.find_by_name('War And Peace')
    end
  end
end

module Extend
  RSpec.describe Extend::Document do
    subject { Extend::Document }
    it_behaves_like "a class with the class methods we expect"
  end
end
