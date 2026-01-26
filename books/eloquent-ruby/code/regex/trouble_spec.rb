#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "differences between fnmatch and regex" do
  it "can fool you" do
    re = /app*.rb/
    expect(re.match?("apppp%rb")).to be_truthy
    expect(re.match?("appppppppppppXrb")).to be_truthy
    expect(re.match?("application_controller.rb")).to be_falsey
  end
end

describe "fnmatch" do
  it "does filesystem style matching" do
    expect(
      File.fnmatch("app*.rb", "application_controller.rb")    # True!
    ).to be_truthy

    expect(
      File.fnmatch("*.txt", "emma.txt")                       # Also true!
    ).to be_truthy

    expect(
      File.fnmatch("*.txt", "emma.docx")                      # Nope.
    ).to be_falsey
  end

it "enables you to be a character in XKCD" do
    # Matches email addresses: <anything>@<anything>.

    EMAIL_RE=/.*@.*/
  
    expect(
      EMAIL_RE.match?("russ@russolsen.com")     # Great!
    ).to be_truthy

    expect(
    # Much less great, with apologies to Randall Munroe.

    EMAIL_RE.match?("robert@example.com'; DROP TABLE STUDENTS;") 
    ).to be_truthy
  end
end
