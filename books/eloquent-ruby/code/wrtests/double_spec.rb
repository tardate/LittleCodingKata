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
require_relative "./printable_document"
require_relative "./printer"


describe "RSpec mocking" do
  let(:doc) do
    PrintableDocument.new(title: "Test", author: "russ", content: "A test")
  end

  let(:printer) {instance_double(Printer, available?: true, render: :complete)}

  it "lets you make a simple mock with double" do
    # Make an object with available? and render methods.

    printer = double(available?: true, render: :complete)

    # And use it to print this document.
    expect(doc.print(printer)).to eq(:complete)
  end

  it "lets you make a verifying mock with instance_double" do
    # Make a mock that resembles a Printer instance.

    printer = instance_double(Printer, available?: true, render: :complete)

    # And use it to print this document.
    expect(doc.print(printer)).to eq(:complete)
  end

  it "will blow up if you specify stray methods" do
    expect do
      # There is no reload_ink method in the Printer class,
      # so this will go boom!

      printer = instance_double(Printer, available?: true, reload_ink: nil)
    end.to raise_error(RSpec::Mocks::MockExpectationError)
  end

  it "supports once" do
    printer = instance_double(Printer)
    expect(printer).to receive(:available?).once.and_return(true)
    printer.available?
  end

  it "supports at_least...times" do
    printer = instance_double(Printer)
    expect(printer).to receive(:available?).at_least(8).times.and_return(true)
    8.times {printer.available?}
  end

  it "supports with" do
    printer = instance_double(Printer)
    text = "Exactly three words"
    expect(printer).to receive(:render).with(text).and_return(:complete)
    printer.render(text)
  end

  it "lets you check after the fact" do
    printer = instance_double(Printer)
    text = "Exactly three words"
    allow(printer).to receive(:render).with(text).and_return(:complete)
    printer.render(text)
  end

  it "lets you make a more demanding verifying mock with instance_double" do
    # Make a mock with an opinion.

    printer = instance_double(Printer)
    expect(printer).to receive(:available?).and_return(true)
    expect(printer).to receive(:render).and_return(:complete)

    # And use it to print this document.
    expect(doc.print(printer)).to eq(:complete)
  end


  it "can also print with an even more demanding printer mock" do
    printer = instance_double(Printer)
    expect(printer).to receive(:available?).and_return(true)
    expect(printer).to receive(:render).with("A test").and_return(:complete)

    # And use it to print this document.
    expect(doc.print(printer)).to eq(:complete)
  end


  it "allows you to check after the fact" do
    printer = instance_double(Printer)
    allow(printer).to receive(:available?).and_return(true)
    allow(printer).to receive(:render).and_return(:complete)

    # Do the printing...
    expect(doc.print(printer)).to eq(:complete)

    # Check that the methods have indeed been called.
    expect(printer).to have_received(:available?)
    expect(printer).to have_received(:render)
  end
end

