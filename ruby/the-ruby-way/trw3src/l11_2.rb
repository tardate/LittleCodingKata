class PersonalComputer
  attr_accessor :manufacturer,
                :model, :processor, :clock,
                :ram, :disk, :monitor,
                :colors, :vres, :hres, :net
  def initialize
    yield self if block_given?
end
  # Other methods...
end

desktop = PersonalComputer.new do |pc|
  pc.manufacturer = "Acme"
  pc.model = "THX-1138"
  pc.processor = "Z1"
  pc.clock = 9.6
  pc.ram = 512
  pc.disk = 20
  pc.monitor = 30
  pc.colors = 16777216
  pc.vres = 1600
  pc.hres = 2000
  pc.net = "OC-768"
end

p desktop
