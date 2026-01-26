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
require_relative "little_logging"

shared_examples "encrypt document" do
  it "encrypt a document" do
    doc = Document.new(author: "Russ", title: "plans", content: "Attack!")
    db = double("database")
    logger = Logger.new(LoggerIO.new, level: :debug)
    expect(db).to receive(:load).with("secret_plans").and_return(doc)
    expect(db).to receive(:save).with("secret_plans", doc)

    expect do
      encrypt_document(db, "secret_plans", logger)
    end.to output(/Start: document load.*Complete: document save/m).to_stdout

    expect(doc.content).to eq("Nggnpx!")
  end
end

shared_examples "handles errors" do
  let(:logger) { Logger.new(LoggerIO.new, level: :debug) }

  it "catches load exceptions" do
    db = double("database")
    expect(db).to receive(:load).with("secret_plans").and_raise(IOError, "Doc load failed")

    expect do
      encrypt_document(db, "secret_plans", logger)
    end.to raise_error(IOError).and output(/Failed: document load/).to_stdout
  end

  it "catches save exceptions" do
    doc = Document.new(author: "Russ", title: "plans", content: "Attack!")
    db = double("database")
    expect(db).to receive(:load).with("secret_plans").and_return(doc)
    expect(db).to receive(:save).with("secret_plans", doc).and_raise(IOError, "Doc save failed")

    expect do
      encrypt_document(db, "secret_plans", logger)
    end.to raise_error(StandardError).and output(/Doc save failed/).to_stdout
  end
end

describe Basic do
  include Basic
  it "should uppercase document contents" do
    doc = Document.new(author: "Russ", title: "plans", content: "Attack!")
    db = double("database")
    expect(db).to receive(:load).with("secret_plans").and_return(doc)
    expect(db).to receive(:save).with("secret_plans", doc)

    encrypt_document(db, "secret_plans")
    expect(doc.content).to eq("Nggnpx!")
  end
end

describe AddLogging do
  include AddLogging
  include_examples "encrypt document"
end

describe Disaster do
  include Disaster
  include_examples "encrypt document"
  include_examples "handles errors"
end

describe LoadSaveLogging do
  include LoadSaveLogging
  include_examples "encrypt document"
  include_examples "handles errors"
end

describe WithLogging do
  include WithLogging
  include_examples "encrypt document"
  include_examples "handles errors"
end

