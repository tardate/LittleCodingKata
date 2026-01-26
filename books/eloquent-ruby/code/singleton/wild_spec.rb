#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "active_record"

module SingletonMethods
  class Author < ActiveRecord::Base
  end

  describe Author do
    it "provides the table name via a class method" do
      my_table_name = Author.table_name
      expect(my_table_name).to eq("authors")
    end
  end
end

describe Date do
  it "provides a familiar way of specifying dates" do
    xmas = Date.civil( 2025, 12, 25 )
    expect(xmas.year).to eq(2025)
    expect(xmas.month).to eq(12)
    expect(xmas.day).to eq(25)
  end

  it "lets you specify dates with year and day" do
    xmas = Date.ordinal( 2025, 359 )
    expect(xmas.year).to eq(2025)
    expect(xmas.month).to eq(12)
    expect(xmas.day).to eq(25)

  end

  it "lets you specify the date by year, week number and day" do
    xmas = Date.commercial( 2025, 52, 4 )
    expect(xmas.year).to eq(2025)
    expect(xmas.month).to eq(12)
    expect(xmas.day).to eq(25)
  end
end
