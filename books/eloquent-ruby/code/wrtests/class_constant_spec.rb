#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

RSpec.describe  "overriding class methods" do

  it "makes it possible to make a mock class methods" do
    # Make a mock File object.

    mock_file = class_double(File)
    expect(mock_file).to receive(:write)

    # Write some data to a file using a class method. But not really...

    mock_file.write("2cities.txt", "It was the best of times...")
  end



  it "makes life easier for math students" do
    # Make life easier for math students.

    stub_const("Math::PI", 3.0000)

    # Compute the area of a circle in this new world.

    radius = 1.0
    area = Math::PI * (radius * radius)

    # Our circle has a nice, rational area.
    # Note the be_with is needed here because we are
    # dealing with floating point numbers.

    expect(area).to be_within(0.0001).of(3.0)
  end


  it "can get rid of pi" do
    # In a world without PI, are all pies rectangular?

    hide_const("Math::PI")

    expect(defined?(Math::PI)).to be_nil
  end
end
