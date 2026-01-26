#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
module NormalAttrAccessor
  class Printer
    attr_accessor :name
  end
end

module ManualAttrAccessor
  class Printer
    def name
      @name
    end

    def name=(value)
      @name = value
    end
  end
end

class Object
  def self.simple_attr_reader(name)
    define_method(name) do
      variable_name = "@#{name}"
      instance_variable_get(variable_name)
    end
  end

  def self.simple_attr_writer(name)
    define_method("#{name}=") do |value|
      variable_name = "@#{name}"
      instance_variable_set(variable_name, value)
    end
  end
end

module SimpleAttrAccessor
  class Printer
    simple_attr_reader :name
    simple_attr_writer :name
  end
end

describe NormalAttrAccessor do
  it "has a name attribute" do
    p = subject::Printer.new
    p.name = 'a printer'
    expect(p.name).to eq('a printer')
    expect(subject::Printer.instance_methods).to include(:name)
    expect(subject::Printer.instance_methods).to include(:name=)
  end
end

describe ManualAttrAccessor do
  it "has a name attribute" do
    p = subject::Printer.new
    p.name = 'a printer'
    expect(p.name).to eq('a printer')
    expect(subject::Printer.instance_methods).to include(:name)
    expect(subject::Printer.instance_methods).to include(:name=)
  end
end

describe SimpleAttrAccessor do
  it "has a name attribute" do
    p = subject::Printer.new
    p.name = 'a printer'
    expect(p.name).to eq('a printer')
    expect(subject::Printer.instance_methods).to include(:name)
    expect(subject::Printer.instance_methods).to include(:name=)
  end
end 
