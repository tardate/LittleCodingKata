#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

describe "Iterators" do
  it "they can leak resources" do
    name_server = double
    expect(name_server).to receive(:open).and_return(true)
    expect(name_server).to receive(:has_more?).and_return(true)
    expect(name_server).to receive(:read_name).and_raise("Boom!")

    def each_name(name_server)
      name_server.open                # Get some expensive resource

      while name_server.has_more?
        yield name_server.read_name
      end

      name_server.close                # Close the expensive resource
    end

    expect do
      each_name(name_server) { |name| puts(name) } 
    end.to raise_error(Exception)
  end

  it "can avoid leaking resources" do
    name_server = double
    expect(name_server).to receive(:open).and_return(true)
    expect(name_server).to receive(:has_more?).and_return(true)
    expect(name_server).to receive(:read_name).and_raise("Boom!")
    expect(name_server).to receive(:close)

    def each_name(name_server)
      name_server.open                # Get some expensive resource

      begin
        while name_server.has_more?
          yield name_server.read_name
        end
      ensure
        name_server.close             # Make sure we close the expensive resource
      end
    end

    expect do
      each_name(name_server) { |name| puts(name) } 
    end.to raise_error(Exception)
  end
end
