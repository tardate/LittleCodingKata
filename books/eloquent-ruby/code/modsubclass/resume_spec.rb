#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "resume"

module Basic
  describe Resume do
    it "lets you build a resume document easily" do
      russ_cv = Resume.new(title: "Resume", author: "RO") do |cv|
        cv.name "Russ Olsen"
        cv.address "1313 Mocking Bird Lane"
        cv.email "russ@russolsen.com"
        cv.body "Brilliant author and terrible singer."
        # ...and so on
      end
      expect(russ_cv.content).to match(/Russ.*13.*olsen.com.*Brilliant/m)
    end
  end
end
