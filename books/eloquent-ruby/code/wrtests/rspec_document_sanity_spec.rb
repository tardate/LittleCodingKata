#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

# This is a bit of a hack so we can do a simple
# require "document" in the example.
#
$LOAD_PATH.push "#{__dir__}/../common"


require "document"

RSpec.describe Document do
  it "should not catch fire when you create an instance" do
    doc = Document.new(title: "title", author: "author", content: "some stuff")
    expect(doc).to_not eq(nil)
  end
end
