#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require "rspec"

module HardWay
  module UsefulInstanceMethods
    def an_instance_method; end
  end

  module UsefulClassMethods
    def a_class_method; end
  end

  class Host
    include UsefulInstanceMethods
    extend UsefulClassMethods
  end
end

describe "instance and class methods the hard way" do
  it "works" do
    expect(HardWay::Host.a_class_method).to be_nil
    expect(HardWay::Host.new.an_instance_method).to be_nil
  end
end

module EasyWay
  module UsefulMethods
    module ClassMethods
      def a_class_method; end
    end

    def self.included(host_class)
      host_class.extend(ClassMethods)
    end

    def an_instance_method; end
  end

  class Host
    include UsefulMethods
  end
end

describe "instance and class methods via included" do
  it "works" do
    expect(EasyWay::Host.a_class_method).to be_nil
    expect(EasyWay::Host.new.an_instance_method).to be_nil
  end
end
