class Person
  attr_reader :name, :age, :height

  def initialize(name, age, height)
    @name, @age, @height = name, age, height
  end

  def inspect
    "#@name #@age #@height"
  end 
end

class Array
  def map_by(sym)
    self.map {|x| x.send(sym) }
  end
end

people = []
people << Person.new("Hansel", 35, 69)
people << Person.new("Gretel", 32, 64)
people << Person.new("Ted", 36, 68)
people << Person.new("Alice", 33, 63)

p1 = people.map_by(:name)    # Hansel, Gretel, Ted, Alice
p2 = people.map_by(:age)     # 35, 32, 36, 33
p3 = people.map_by(:height)  # 69, 64, 68, 63

