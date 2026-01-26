#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require "net/http"

describe "lambda blocks" do
  it "takes parameters and returns a value" do 
    block = lambda {|x| x+1}
    expect(block.call(1)).to eq(2)
    expect(block.call(999)).to eq(1000)
  end

  it "cares deeply about the number of arguments" do 
    block = lambda {|x| x+1}
    expect(block.call(42)).to eq(43)
    expect {block.call}.to raise_exception(Exception);
    expect {block.call(1,2,3)}.to raise_exception(Exception);
  end

  it "will just return from the block with a return" do |block_with_return|
    expect do
      block = lambda do
        return :from_block
      end
      block.call
      puts "done!"
    end.to output(/done!/).to_stdout
  end
end

describe "pointy lambda blocks" do
  it "takes parameters and returns a value" do 
    block = ->(x) {x+1}
    expect(block.call(1)).to eq(2)
    expect(block.call(999)).to eq(1000)
  end

  it "cares deeply about the number of arguments" do 
    block = ->(x) {x+1}
    expect(block.call(42)).to eq(43)
    expect {block.call}.to raise_exception(Exception);
    expect {block.call(1,2,3)}.to raise_exception(Exception);
  end

  it "will just return from the block with a return" do |block_with_return|
    expect do
      block = ->() do
        return :from_block
      end
      block.call
      puts "done!"
    end.to output(/done!/).to_stdout
  end
end

describe "proc blocks" do
  it "words pretty much like a lambda block" do
    from_proc_new = Proc.new { puts "hello from a block" }
    expect { from_proc_new.call }.to output(/hello from a block/).to_stdout
  end

  it "takes parameters and returns a value" do 
    block = proc {|x| x+1}
    expect(block.call(1)).to eq(2)
    expect(block.call(999)).to eq(1000)
  end

  it "cares deeply about the number of arguments" do 
    block = proc {|x| x.inspect}
    expect(block.call(42)).to eq("42")
    expect(block.call).to eq("nil")
    expect(block.call(77,88,99)).to eq("77")
  end
end

def run_block_with_3_args
  yield(100, 200, 300)
end

describe "default blocks" do
  it "doesn't care about number of arguments" do
    expect do
      run_block_with_3_args do |a|
        puts a
      end
    end.to output(/100/).to_stdout

    expect do
      run_block_with_3_args do |a, b, c|
        puts a, b, c
      end
    end.to output(/100.*200.*300/m).to_stdout

    expect do
      run_block_with_3_args do |a, b, c, d, e, f|
        puts "d is nil" if d.nil?
      end
    end.to output(/d is nil/).to_stdout
  end
end
