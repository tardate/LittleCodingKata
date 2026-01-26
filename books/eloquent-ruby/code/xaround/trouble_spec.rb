#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "little_logging"

describe "Choice of method names" do
  include WithLogging

  let(:employee) do
    emp = double("employee")
    expect(emp).to receive(:load)
    expect(emp).to receive(:status=).with(:retired)
    expect(emp).to receive(:save)
    emp
  end

  it "bad names don't sing" do
    alias :execute_between_logging_statements :with_logging

    expect do
      execute_between_logging_statements "Update employee" do
        employee.load
        employee.status = :retired
        employee.save
      end
    end.to output(/Start: Update em.*Complete.*Up/m).to_stdout
  end

  it "good names do sing" do
    expect do
      with_logging "Update employee" do
        employee.load
        employee.status = :retired
        employee.save
      end
    end.to output(/Start: Update em.*Complete.*Up/m).to_stdout
  end
end
