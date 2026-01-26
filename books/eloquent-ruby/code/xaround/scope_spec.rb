#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "../common/logging_util"
require_relative "scope"

shared_examples "with_logging" do |mod|
  let(:logger) { Logger.new(LoggerIO.new) }
  let(:doc) { Document.new(author: "russ", title: "test", content: "abcd") }
  let(:old_path) { "old.txt" }

  it "logs the things we expect when save works" do
    new_path = "new.txt"
    expect(Document).to receive(:load).with(old_path).and_return(doc)
    expect(doc).to receive(:save).with(new_path)
    expect do
      mod.upcase_document(old_path, new_path)
    end.to output(/Start.*save.*Complete.*save/m).to_stdout
  end

  it "logs the things we expect when save fails" do
    new_path = "new.txt"
    expect(Document).to receive(:load).with(old_path).and_return(doc)
    expect(doc).to receive(:save).with(new_path).and_raise(StandardError.new("oh no"))
    expect do
      mod.upcase_document(old_path, new_path)
    end.to raise_error(StandardError).and output(/failed/).to_stdout
  end
end

describe RedundantArgument do
  include_examples "with_logging", RedundantArgument
end

describe BlocksAreClosures do
  include_examples "with_logging", BlocksAreClosures
end

class Database; end

module MethodGeneratedArgument
  describe "generating an argument inside the xaround method" do
    it "works as described" do
     connection_info = { db: "books", user: "russ" }
     db = "The open connection"
     expect(Database).to receive(:new).with(connection_info).and_return(db)
     expect(db).to receive(:close)

     expect do 
       MethodGeneratedArgument.with_database_connection(connection_info) do |conn|
         puts "Connection: #{conn}"
       end
     end.to output(/The open connection/m).to_stdout
    
    end
  end
end
