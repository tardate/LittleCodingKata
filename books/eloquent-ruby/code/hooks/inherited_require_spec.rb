#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

require_relative "document_reader"
require_relative "yaml_reader"       # inherited fires for YAMLReader
require_relative "json_reader"       # inherited fires for JSonReader
require_relative "plain_text_reader" # inherited fires for PlainTextReader


describe "inherited hook" do
  it "gets called for each subclass" do
    expected = [YAMLReader, JSONReader, PlainTextReader]
    expected.each do |clazz|
      expect(DocumentReader.reader_classes.include?(clazz)).to be_truthy
    end
  end
end
