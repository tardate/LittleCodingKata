class IntelligentLife
  class << self
    attr_accessor :home_planet
  end
  #... 
end

class Terran < IntelligentLife
  self.home_planet = "Earth"
  #...
end

class Martian < IntelligentLife
  self.home_planet = "Mars"
  #...
end

puts Terran.home_planet
puts Martian.home_planet
