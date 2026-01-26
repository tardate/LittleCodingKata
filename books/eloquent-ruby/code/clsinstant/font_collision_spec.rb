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

class Document
  @@default_font = :comic_sans

  # Rest of the class omitted.
end

class Document
  def self.default_font=(font)
    @@default_font = font
  end

  def self.default_font
    @@default_font
  end
end

require_relative "resume"
require_relative "presentation"

describe "Resume/Presentation fonts now collide" do
  it "means that there is only one font for all 3 classes" do
    # Nimbus is set by Presentation, which is the last class loaded above."
    expect(Document.default_font).to eq(:nimbus)
    expect(Presentation.default_font).to eq(:nimbus)
    expect(Resume.default_font).to eq(:nimbus)

    Resume.default_font = :fixed
    expect(Document.default_font).to eq(:fixed)
    expect(Presentation.default_font).to eq(:fixed)

    Presentation.default_font = :times
    expect(Document.default_font).to eq(:times)
    expect(Resume.default_font).to eq(:times)
  end
end


