#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "document_reader"
require_relative "asian_document_reader"


describe "inherited hook" do
  it "gets called on intermediate superclasses" do
    expect(DocumentReader.reader_classes.include?(AsianDocumentReader)).to be_truthy
    expect(DocumentReader.reader_classes.include?(JapaneseDocumentReader)).to be_truthy
    expect(DocumentReader.reader_classes.include?(ChineseDocumentReader)).to be_truthy
  end
end
