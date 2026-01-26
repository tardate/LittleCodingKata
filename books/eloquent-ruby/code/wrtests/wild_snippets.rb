#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---

=begin
# See https://github.com/ruby/spec/blob/4d2fc4d9c5cbc5b8350979a534928d615bfd233a/language/if_spec.rb#L21

 describe "The if expression" do
    # Most of the spec omitted...

   it "evaluates body if expression is true" do
    a = []
    if true
      a << 123
    end
    a.should == [123]
  end

  it "does not evaluate body if expression is false" do
    a = []
    if false
      a << 123
    end
    a.should == []
  end
  # ...
end

# See: https://github.com/ruby/spec/blob/4d2fc4d9c5cbc5b8350979a534928d615bfd233a/language/array_spec.rb#L4C1-L11C6

describe "Array literals" do
  # Most of the spec omitted...

  it "[] should return a new array populated with the given elements" do
    array = [1, "a", nil]
    array.should be_kind_of(Array)
    array[0].should == 1
    array[1].should == "a"
    array[2].should == nil
  end
  # ...
=end


