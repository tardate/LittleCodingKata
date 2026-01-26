#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_encrypt_cls_method"

module EncryptClassMethod
  describe Document do
    it "lets you turn encryption on" do
      Document.enable_encryption(true)
      doc = Document.new(title: "test", author: "russ", content: "abc")
      expect(doc.encrypt("abc")).to eq("mno")
    end

    it "lets you turn decryption off" do
      Document.enable_encryption(false)
      doc = Document.new(title: "test", author: "russ", content: "abc")
      expect(doc.encrypt("abc")).to eq("abc")
    end
  end
end
