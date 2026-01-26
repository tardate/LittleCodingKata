#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "net/http"
require_relative "archival_doc"

describe BlockBasedArchivalDocument do
  it "doesn't have @content until you call content" do
    bbad = BlockBasedArchivalDocument.new(title: "File", author: "Russ") do
      "Hello world!"
    end

    expect(bbad.instance_variables.include?(:@content)).to be_falsey
    expect(bbad.content).to match(/Hello world!/)
    expect(bbad.instance_variables.include?(:@content)).to be_truthy
  end

  it "lets you read your doc from a file" do
    file_doc = BlockBasedArchivalDocument.new(title: "File", author: "Russ") do
      File.read("some_text.txt")
    end

    expect(file_doc.content).to match(/This is some text./)
  end

  it "lets you read your doc from http" do
    response = double("response")
    expect(response).to receive(:body).and_return("From net.")
    expect( Net::HTTP).to receive(:get_response).with("example.com", "/index.html").and_return(response)

    net_doc = BlockBasedArchivalDocument.new(title: "HTTP", author: "Russ") do
      Net::HTTP.get_response("example.com", "/index.html").body
    end
    expect(net_doc.content).to eq("From net.")
  end

  it "lets you make up the contents of your doc" do
    silly_doc = BlockBasedArchivalDocument.new(title: "Silly", author: "Russ") do
      "Da" * 100
    end
    expect(silly_doc.content).to match(/(Da){100}/)
  end
end
