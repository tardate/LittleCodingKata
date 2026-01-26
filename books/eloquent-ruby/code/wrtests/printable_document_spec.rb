#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"
require_relative "./printable_document"
require_relative "./printer"

require "rspec"

describe PrintableDocument do
  let(:doc) do
    PrintableDocument.new(title: "Test", author: "russ", content: "A test")
  end

  let(:online_printer) do
    instance_double(Printer, available?: true, render: :complete)
  end

  let(:offline_printer) { instance_double(Printer, available?: false) }

  it "knows how to print itself" do
    expect(doc.print(online_printer)).to eq(:complete)
  end

  it "can deal with an offline printer" do
    expect(doc.print(offline_printer)).to eq(:printer_unavailable)
  end
end
