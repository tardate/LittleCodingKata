class SomeClass
  def initialize
    @a = 1
    @b = 2 
  end
  def mymeth
    #...
  end
  protected :mymeth
end

x = SomeClass.new

def x.newmeth
  # ...
end

iv = x.instance_variables      # [:@a, :@b]

x.methods.size                 # 61

x.public_methods.size          # 60 
x.public_methods(false).size   # 1

x.private_methods.size         # 85 
x.private_methods(false).size  # 1  
￼￼
x.protected_methods.size       # 1
x.singleton_methods.size       # 1
