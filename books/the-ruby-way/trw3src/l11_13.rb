class IntelligentLife
  def IntelligentLife.home_planet
    class_eval("@@home_planet")
  end
￼￼
  def IntelligentLife.home_planet=(x)
    class_eval("@@home_planet = #{x}")
  end

  #... 
end

class Terran < IntelligentLife
  @@home_planet = "Earth"
  #...
end

class Martian < IntelligentLife
  @@home_planet = "Mars"
  #...
end

puts Terran.home_planet
puts Martian.home_planet
