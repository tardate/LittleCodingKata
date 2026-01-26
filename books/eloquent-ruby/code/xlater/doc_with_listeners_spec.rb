#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "fileutils"
require_relative "doc_with_listeners"

module TraditionalListeners
  describe Document do
    after(:all) do
      FileUtils.rm_f("new_doc.txt")
    end

    it "calls back into the listeners at the right times." do
      FileUtils.rm_f("new_doc.txt")

      expect do
        doc = Document.new(title: "Example", author: "Russ", content: "Left Blank!")
        doc.load_listener = DocumentLoadListener.new
        doc.save_listener = DocumentSaveListener.new

        doc.load("doc.txt")
        doc.save("new_doc.txt")
      end.to output(/Hey.*loaded.*Hey.*saved/m).to_stdout

      orig_text = File.read("doc.txt")
      expect(File.read("new_doc.txt")).to eq(orig_text)
    end
  end
end

module BlockListeners
  describe Document do
    after(:all) do
      FileUtils.rm_f("new_doc.txt")
    end

    it "lets you supply blocks for listeners" do
      my_doc = Document.new(title: "Block example", author: "Russ", content: "...")

      my_doc.on_load { |doc, path| puts "Hey, I've been loaded!" }
      my_doc.on_save { |doc, path| puts "Hey, I've been saved!" }
      expect do
        FileUtils.rm_f("new_doc.txt")
        my_doc.load("doc.txt")
        my_doc.save("new_doc.txt")
      end.to output(/Hey.*loaded.*Hey.*saved/m).to_stdout
      orig_text = File.read("doc.txt")
      expect(File.read("new_doc.txt")).to eq(orig_text)
    end
  end
end
