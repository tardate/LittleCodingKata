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

describe Dir do
  it "includes Dir.each" do
    expect do
      puts "Contents of /etc directory:"
      
      etc_dir = Dir.new("/etc")
      etc_dir.each { |entry| puts entry }
    end.to output(/passwd/).to_stdout
  end
end

describe "Resolv" do
  it "includes Resolv.each_address" do
    expect do
      require "resolv"

      Resolv.each_address("khanacademy.org") { |x| puts x }
    end.to output(/\d+\.\d+\.\d+\.\d+/).to_stdout
  end
end
