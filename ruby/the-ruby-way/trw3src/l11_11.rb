module Quantifier
  def two?
    2 == self.select { |x| yield x }.size
  end
  def four?
    4 == self.select { |x| yield x }.size
  end 
end

list = [1, 2, 3, 4, 5]
list.extend(Quantifier)

flag1 = list.two? {|x| x > 3 }
flag2 = list.two? {|x| x >= 3 }
flag3 = list.four? {|x| x <= 4 } 
flag4 = list.four? {|x| x % 2 == 0 }
