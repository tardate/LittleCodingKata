#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative '../common/document'

describe 'variable modification' do
  it 'works the way you expect' do
    name = "McDevitt"

    expect(name).to eq("McDevitt")

    name = "Jack McDevitt"
    #
    expect(name).to eq("Jack McDevitt")
  end
end

module ChangeDocument
  describe 'patching classes' do

    it 'happens on the fly' do
      class Document
        attr_accessor :title, :author, :content

        def initialize(title:, author:, content:)
          @title = title
          @author = author
          @content = content
        end
      end

      expect(Document.instance_methods.include?(:words)).to be_falsey
      expect(Document.instance_methods.include?(:word_count)).to be_falsey

      class Document
        def words = @content.split
        def word_count = words.size
      end

      expect(Document.instance_methods.include?(:words)).to be_truthy
      expect(Document.instance_methods.include?(:word_count)).to be_truthy

      cover_letter = Document.new(
        title: "Letter",
        author: "Russ", 
        content: "Here's my resume"
      )

      expect(cover_letter.methods.include?(:average_word_length)).to be_falsey

      class Document
        def average_word_length
          total_length = words.sum(&:size)
          total_length.fdiv(word_count)
        end
      end

      expect(cover_letter.methods.include?(:average_word_length)).to be_truthy

      cover_letter.average_word_length

      # 14 characters in 3 words.
      expect(cover_letter.average_word_length).to eq(14.fdiv(3))
    end
  end
end
