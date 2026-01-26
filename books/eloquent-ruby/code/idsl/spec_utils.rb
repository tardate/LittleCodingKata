#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "fileutils"

DIR="marketing"
F1= "#{DIR}/brochure.txt"
F2= "#{DIR}/ad_copy.txt"

def create_marketing_documents
  delete_marketing_documents

  FileUtils.mkdir_p DIR

  open(F1, "w") do |f|
    f.puts "title: Spacely Sprockets Brochure"
    f.puts ""
    f.puts "We here at Spacely Sprockets have great products."
  end

  open(F2, "w") do |f|
    f.puts "title: Spacely Sprockets advertisement copy"
    f.puts ""
    f.puts "Spacely Sprockets make the world go round."
  end
end

def delete_marketing_documents
  FileUtils.rm_rf DIR
end
