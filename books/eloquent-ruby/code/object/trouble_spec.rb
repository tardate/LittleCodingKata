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
require_relative "message"

describe Message do
  let(:m) do
    Message.new(
      author: "bob@example.com",
      title: "On vacation!",
      content: "EOM"
    )
  end

  it "is functional as a document" do
    expect(m.author).to eq("bob@example.com")
  end

  it "breaks the Object method send" do
    expect(m.send(:object_id)).to be_nil
    expect(m.send(:to_s)).to be_nil
  end

  it "has a broken to_s method" do
    expect{ m.to_s }.to raise_error(NameError)
  end
end

describe Object do
  it "is possible to do things the long way" do
    expect do
      [nil, 123, :other].each do |the_object|
        if the_object.nil?
          puts "The object is nil"
        elsif the_object.instance_of?(Integer)
          puts "The object is an integer"
        else
          puts "The object is an instance of #{the_object.class}"
        end
      end
    end.to output(/nil.*integer.*Symbol/m).to_stdout
  end

  it "is possible to do it the easy way" do
    the_object = 123
    expect do
    puts "The object is an instance of #{the_object.class}"
    end.to output(/instance.*Int/).to_stdout
  end
end
