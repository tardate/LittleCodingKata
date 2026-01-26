#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"
require_relative "person"

describe Person do
  let(:p) { Person.new(salary: 100, name: "Bob", password: "xyzzy") }

  it "is functional" do
    expect(p.salary).to eq(100)
    expect(p.name).to eq("Bob")
    expect(p.instance_variable_get(:@password)).to eq("xyzzy")
  end

  it "has writers for salary and password" do
    p.salary = 999
    p.password = "secret"
    expect(p.salary).to eq(999)
    expect(p.instance_variable_get(:@password)).to eq("secret")
  end

  it "doesn't have a writer for name" do
    expect { p.method(:name=) }.to raise_error(NameError)
    expect { p.method(:password) }.to raise_error(NameError)
  end
end
