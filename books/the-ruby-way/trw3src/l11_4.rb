class MyClass            
            
  SOME_CONST = "alpha"       # A class-level constant   
            
  @@var = "beta"             # A class variable
  @var = "gamma"             # A class instance variable
            
  def initialize            
    @var = "delta"           # An instance variable
  end            
            
  def mymethod            
    puts SOME_CONST          # (the class constant)
    puts @@var               # (the class variable)
    puts @var                # (the instance variable)
  end            
            
  def self.classmeth1            
    puts SOME_CONST          # (the class constant)
    puts @@var               # (the class variable)
    puts @var                # (the class instance variable)
  end             
end            
            
def MyClass.classmeth2            
  puts MyClass::SOME_CONST   # (the class constant)
  # puts @@var               # error – out of scope
  puts @var                  # (the class instance variable)
end            
            
myobj = MyClass.new            

MyClass.classmeth1           # alpha, beta, gamma
MyClass.classmeth2           # alpha, gamma
myobj.mymethod               # alpha, beta, delta

















