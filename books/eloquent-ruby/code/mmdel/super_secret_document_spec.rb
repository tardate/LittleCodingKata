#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "super_secret_document"

def get_instructions
  Document.new(
    author: "Russ", 
    title: "Instructions", 
    content: "Cut the blue wire."
  )
end

RSpec.shared_examples "document expiration" do |secret_doc_class|
  it "expires" do
    doc = get_instructions

    secret_doc = secret_doc_class.new(
      original_document: doc,
      time_limit_in_seconds: 0.4
    )

    # Race condition here, but let it go...

    expect(secret_doc.time_expired?).to be_falsey
    expect(secret_doc.author).to eq(doc.author)
    expect(secret_doc.title).to eq(doc.title)
    expect(secret_doc.content).to eq(doc.content)

    sleep(0.51)

    expect(secret_doc.time_expired?).to be_truthy
    expect { secret_doc.author }.to raise_error(Exception)
    expect { secret_doc.title }.to raise_error(Exception)
    expect { secret_doc.content }.to raise_error(Exception)
  end
end

module Basic
  describe SuperSecretDocument do
    include_examples "document expiration", SuperSecretDocument

    it "wraps normal documents" do
      original_instructions = get_instructions

      instructions = SuperSecretDocument.new(
        original_document: original_instructions,
        time_limit_in_seconds: 5
      )
    end
  end
end

module MoreReal
  describe SuperSecretDocument do
    include_examples "document expiration", SuperSecretDocument
  end
end

module MMImplementation
  describe SuperSecretDocument do
    include_examples "document expiration", SuperSecretDocument

    it "is completely generic" do
      expect do
        string = "Good morning, Mr. Phelps"
        
        secret_string = SuperSecretDocument.new(
          original_document: string,
          time_limit_in_seconds: 0.25
        )

        puts secret_string.length # Works fine
        sleep 0.50
        puts secret_string.length # Raises exception
      end.to raise_error(Exception).and output(/24/).to_stdout
    end

    it "does something unexpected with to_s" do
      expect do
        original_instructions = get_instructions

        instructions = SuperSecretDocument.new(
          original_document: original_instructions,
          time_limit_in_seconds: 5
        )

        puts instructions.to_s
      end.to output(/SuperSecret/).to_stdout
    end
  end
end

module MoreDiscriminating
  describe SuperSecretDocument do
    it "only delegates content and words" do
      doc = get_instructions

      secret_doc = SuperSecretDocument.new(
        original_document: doc,
        time_limit_in_seconds: 0.01
      )

      # Race condition here, but let it go...

      expect(secret_doc.time_expired?).to be_falsey
      expect(secret_doc.content).to eq(doc.content)
      expect(secret_doc.words).to eq(doc.words)

      expect { secret_doc.author }.to raise_error(Exception)

      sleep(0.1)

      expect(secret_doc.time_expired?).to be_truthy
    end
  end
end

module FromBasicObject
  describe SuperSecretDocument do
    include_examples "document expiration", SuperSecretDocument

    it "does the expected thing with to_s" do
      expect do
        instructions = SuperSecretDocument.new(
          original_document: get_instructions,
          time_limit_in_seconds: 5
        )
        puts instructions.to_s
      end.to output(/^#<Document:.*>/).to_stdout
    end
  end
 end
