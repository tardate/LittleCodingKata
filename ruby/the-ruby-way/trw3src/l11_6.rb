module MyMod
  def self.included(klass)
    def klass.module_method
      puts "Module (class) method"
    end
  end

  def method_1
    puts "Method 1"
  end 
end

class MyClass
  include MyMod
  def self.class_method
    puts "Class method"
  end

  def method_2
    puts "Method 2"
  end 
end

x = MyClass.new
                       # Output:
MyClass.class_method   #  Class method
x.method_1             #  Method 1
MyClass.module_method  #  Module (class) method
x.method_2             #  Method 2
