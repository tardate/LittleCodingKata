#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

def run_that_block(&block_function)
  puts "About to run the block"
  block_function.call
  puts "Done running the block"
end

def run_block_with_check(&block)
  block.call if block
end

describe "explicit code block" do
  it "enables you to capture a code block passed into a method" do
    expect do
      run_that_block { puts "Code block!" }
    end.to output(/About.*Code block!.*Done/m).to_stdout
  end

  it "passes nil if the block is missing" do
    expect do
      run_block_with_check { puts "Code block!" }
    end.to output(/Code block!/).to_stdout

    expect { run_block_with_check }.to output("").to_stdout
    expect(run_block_with_check).to be_nil
  end
end
