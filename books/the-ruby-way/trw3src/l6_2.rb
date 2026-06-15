class Roman
  include Comparable

  I,IV,V,IX,X,XL,L,XC,C,CD,D,CM,M =
    1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000

  Values = %w[M CM D CD C XC L XL X IX V IV I]

  def Roman.encode(value)
    return "" if self == 0
    str = ""
    Values.each do |letters|
      rnum = const_get(letters)
      if value >= rnum
        return(letters + str=encode(value-rnum))
      end
    end
    str 
  end

  def Roman.decode(rvalue)
    sum = 0
    letters = rvalue.split('')
    letters.each_with_index do |letter,i|
      this = const_get(letter)
      that = const_get(letters[i+1]) rescue 0
      op = that > this ? :- : :+
      sum = sum.send(op,this)
    end
    sum 
  end

  def initialize(value)
    case value
      when String
        @roman = value
        @decimal = Roman.decode(@roman)
      when Symbol
        @roman = value.to_s
        @decimal = Roman.decode(@roman)
      when Numeric
        @decimal = value
        @roman = Roman.encode(@decimal)
    end 
  end

  def to_i
    @decimal
  end

  def to_s
    @roman
  end

  def succ
    Roman.new(@decimal+1)
  end

  def <=>(other)
    self.to_i <=> other.to_i
  end 
end

def Roman(val)
  Roman.new(val)
end
