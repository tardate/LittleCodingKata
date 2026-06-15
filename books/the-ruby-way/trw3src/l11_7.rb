module MyMod
  def meth3
    puts "Module instance method meth3"
    puts "can become a class method."
  end 
end

class MyClass
  class << self     # Here, self is MyClass
    include MyMod
  end 
end

MyClass.meth3

# Output:
#   Module instance method meth3
#   can become a class method.

