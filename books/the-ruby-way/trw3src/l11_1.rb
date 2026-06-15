class ColoredRectangle

  def initialize(r, g, b, s1, s2)
    @r, @g, @b, @s1, @s2 = r, g, b, s1, s2
  end

  def self.white_rect(s1, s2)
    new(0xff, 0xff, 0xff, s1, s2)
  end

  def self.gray_rect(s1, s2)
    new(0x88, 0x88, 0x88, s1, s2)
  end

  def self.colored_square(r, g, b, s)
    new(r, g, b, s, s)
  end

  def self.red_square(s)
    new(0xff, 0, 0, s, s)
  end

  def inspect
    "#@r #@g #@b #@s1 #@s2"
  end 
end

a = ColoredRectangle.new(0x88, 0xaa, 0xff, 20, 30)
b = ColoredRectangle.white_rect(15,25)
c = ColoredRectangle.red_square(40)
