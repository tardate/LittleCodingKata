#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "a Ruby string" do
  it "a single quoted string lets you escape single quotes" do
    a_string_with_a_quote = 'Say it ain\'t so!'
    expect(a_string_with_a_quote).to match(/'/)
  end

  it "a single quoted string lets you escape backslahes" do
    a_string_with_a_backslash = 'This is a backslash: \\'
    expect(a_string_with_a_backslash).to match(/\\/)
  end

  it "double quoted strings support various escape sequences" do
    double_quoted = "I have a tab: \t and a newline: \n"
    expect(double_quoted).to match(/\t.*\n/m)
  end

  it "double quoted strings do interpolation" do
    expect {
      author = "Ben Bova"
      title = "Mars"

      puts "#{title} is written by #{author}"
    }.to output(/Mars is.*by Ben/m).to_stdout
  end

  it "lets you get double quotes in a couple of ways" do
    double_quoted = "\"Stop,\" he said, \"Too many backslashes!\""
    expect(double_quoted).to match(/".*".*"/)

    single_quoted = '"Stop," he said, "Too many backslashes!"'
    expect(double_quoted).to match(/".*".*"/)
    expect(double_quoted).to eq(single_quoted)
  end

  it "lets you have have d and s quotes if you are careful" do
    str = '"Stop," he said, "I can\'t live without \'s and "s."'
    expect(str).to match(/".*".*'.*'.*"/)
  end

  it "makes it easier with percent paren" do
    str = %("Stop," he said, "I can't live without 's and "s.")
    expect(str).to match(/"Stop,.*".*".*'.*'.*"/)
  end

  it "lets you do interpolation or not" do
    str = %(The time is now #{Time.now})
    expect(str).to match(/The time is.*\d\d\d\d-\d\d/)


    str = %q(The time is now #{Time.now})
    expect(str).to match(/The time is.*Time.now/)
  end

  it "lets you embed newlines" do
    a_multiline_string = "a multi-line
  string"

    another_one = %(a multi-line
  string)

    expect(a_multiline_string).to match(/line\n/m)
    expect(another_one).to match(/line\n/m)
  end

  it "supports here docs" do
    heres_one = <<-EOF
    This is the beginning of my here document.
    And this is the end.
    EOF
    expect(heres_one).to match(/ *This.*\n *And this/m)
  end

  it "removes spaces on the front of ~ here docs" do
    verbose = true
    if verbose
      message = <<~EOF
      Here documents can be very useful in
      constructing long multiline strings.
      EOF
    end
    expect(message).to match(/^Here doc.*strings\.$/m)
  end

  it "leaves leading spaces on the front of regular here docs" do
    verbose = true
    # Note the dash.
    if verbose
      message = <<-EOF
      Warning: Note the dash in the line above.
      This leaves the leading whitespace in the string.
      EOF
    end
    expect(message).to match(/^      Warning/)
  end
end
