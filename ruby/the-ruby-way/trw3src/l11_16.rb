class Parent
  def alpha
    puts "parent alpha"
  end
  def beta
    puts "parent beta"
  end 
end

class Child < Parent
  def alpha
    puts "child alpha"
  end
  def beta
    puts "child beta"
  end

  remove_method :alpha   # Remove "this" alpha
  undef_method :beta     # Remove every beta
end

x = Child.new

x.alpha          # parent alpha
x.beta           # Error!

