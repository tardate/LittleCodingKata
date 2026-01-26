#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "doc_encrypt_cls_method_broken"

module MissingEncryptClassMethodCall
  describe Document do
    it "starts with no encrypt method at all" do
      methods = Document.methods
      expect(methods).to_not include(:encrypt)
    end
  end
end

module MispelledMethod
  describe Document do
    it "defines an encrypt method when you enable encryption" do
      Document.enable_encryption(true)
      methods = Document.methods
      expect(methods).to_not include(:encrypt)
    end

    it "defines an incrypt(sic) method when you enable encryption" do
      Document.enable_encryption(false)
      methods = Document.methods
      expect(methods).to_not include(:incrypt)
    end

    it "defines an both methods when you toggle encryption" do
      Document.enable_encryption(false)
      Document.enable_encryption(true)
      methods = Document.methods
      expect(methods).to_not include(:incrypt)
      expect(methods).to_not include(:encrypt)
    end
  end
end
