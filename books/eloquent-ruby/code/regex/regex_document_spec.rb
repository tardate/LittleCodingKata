#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "regex_document"

RSpec.describe Document do
  describe "#obscure_times!" do
    it "replaces all occurrences of times in the format 'HH:MM AM/PM' with '**:** **'" do
      document = Document.new(
        title: "Not Important",
        author: "An RSpec test",
        content: "Meeting is at 10:45 AM and ends at 03:15 PM."
      )

      document.obscure_times!
      expect(document.content).to eq("Meeting is at **:** ** and ends at **:** **.")
    end

    it "does not modify content without valid time strings" do
      document = Document.new(
        title: "Not Important",
        author: "An RSpec test",
        content: "There are no times here."
      )

      document.obscure_times!
      expect(document.content).to eq("There are no times here.")
    end

    it "does not match lowercase or malformed time strings" do
      document = Document.new(
        title: "Not Important",
        author: "An RSpec test",
        content: "It starts at 9:00 am or maybe 9:00AM."
      )

      document.obscure_times!
      expect(document.content).to eq("It starts at 9:00 am or maybe 9:00AM.")
    end
  end
end
