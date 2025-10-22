require 'singleton'

class MyClass
  include Singleton
end

puts a = MyClass.instance
puts b = MyClass.instance
