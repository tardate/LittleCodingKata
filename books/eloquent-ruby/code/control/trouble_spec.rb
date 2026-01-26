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

describe "trouble with modifiers after long blocks" do
  let(:doc) { double("Document") }

  it "should have a working short block example" do
    expect(doc).to receive(:translate).once

    translation_required = true
    translated_doc = doc.translate() if translation_required
  end

  it "should have a working long block example" do
    expect(doc).to receive(:spellcheck).once

    spellcheck_required = true
    spell_checked_doc = doc.spellcheck do |word|
      # 800 
      # lines of 
      # spell checking
      # exception
      # logic.
      # #
    end if spellcheck_required 
  end
end

def test_for_true(flag)
  if flag == true
    # do something
    "yes"
  end
end

describe "Ruby idea of truthiness" do
  it "considers 0 truthy" do
    expect {
    if 0
      puts "Sorry Dennis Ritchie and Brendan Eich."
      puts "But 0 is truthy in Ruby"
    end
    }.to output(/Sorry/).to_stdout
  end

  it "considers 0 truthy" do
    expect {
      puts "Sorry Guido, but [] is truthy in Ruby!" if []
    }.to output(/Sorry/).to_stdout
  end

  it "considers the string 'false' truthy" do
    expect {
      # Note: The expression below will generate a Ruby warning.
      # Note: The warning is OK, this is an example of what not to do!
      puts "Sorry but 'false' is not false" if "false"
    }.to output(/Sorry/).to_stdout
  end

  it "means that testing for true explicitly is a bad idea" do
    expect(test_for_true(true)).to eq("yes")
    expect(test_for_true(1)).to be_nil
  end

  it "means that defined returns neither true nor false" do
    doc = Document.new(
      author: "Shakespeare",
      title: "A Question",
      content: "To be...")

    flag = defined?(doc)
    expect(flag).to eq("local-variable")
    expect(test_for_true(flag)).to be_nil
  end
end

describe "trouble with confusing nil and false" do
  let(:reader) { double("Reader") }

  it "should have a correct next_object example" do
    expect(reader).to receive(:read_next_object).exactly(3).times.and_return(1, 2, nil)
    # Broken in a subtle way...
    while next_object = reader.read_next_object
      # Do something with the object
    end
  end

  it "should have a correct checking for nil with ==" do
    expect(reader).to receive(:read_next_object).exactly(5).times.and_return(1, 2, false, 88, nil)

    until (next_object = reader.read_next_object) == nil
      # Do something with the object
    end 
  end

  it "should have a correct next_object example" do
    expect(reader).to receive(:read_next_object).exactly(5).times.and_return(1, 2, false, 88, nil)

    until (next_object = reader.read_next_object).nil?
      # Do something with the object
    end
  end
end



