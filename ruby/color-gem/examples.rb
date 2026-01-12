#!/usr/bin/env ruby
require 'color'
require 'color/rgb/colors'

def rgb_examples
  puts "\n# RGB examples"
  eg1 = Color::RGB.from_html('#0000FF')
  puts "Color::RGB.from_html('#0000FF')                   : #{eg1}"

  eg2 = Color::RGB.from_values(51, 255, 102)
  puts "Color::RGB.from_values(51, 255, 102)              : #{eg2}"
  puts "Color::RGB.from_values(51, 255, 102).hex          : #{eg2.hex}"

  eg4 = Color::RGB.new(r: 1.0, g: 0.2, b: 0.45)
  puts "Color::RGB.new(r: 1.0, g: 0.2, b: 0.45)           : #{eg4}"

  eg5 = Color::RGB::Blue
  puts "Color::RGB::Blue                                  : #{eg5}"

  eg3 = Color::RGB.new(1.0, 0.2, 0.45)
  puts "Color::RGB.new(1.0, 0.2, 0.45)                    : #{eg3}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).inspect            : #{eg3.inspect}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_h               : #{eg3.to_h}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_a               : #{eg3.to_a}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).r                  : #{eg3.r}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).red                : #{eg3.red}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).g                  : #{eg3.g}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).green              : #{eg3.green}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).b                  : #{eg3.b}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).blue               : #{eg3.blue}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).hex                : #{eg3.hex}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).html               : #{eg3.html}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).css                : #{eg3.css}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_cmyk            : #{eg3.to_cmyk}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_grayscale       : #{eg3.to_grayscale}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_hsl             : #{eg3.to_hsl}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_lab             : #{eg3.to_lab}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_xyz             : #{eg3.to_xyz}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_yiq             : #{eg3.to_yiq}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).to_internal        : #{eg3.to_internal}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).darken_by(10)      : #{eg3.darken_by(10)}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).lighten_by(10)     : #{eg3.lighten_by(10)}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).adjust_brightness(10) : #{eg3.adjust_brightness(10)}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).adjust_saturation(10) : #{eg3.adjust_saturation(10)}"
  puts "Color::RGB.new(1.0, 0.2, 0.45).adjust_hue(10)     : #{eg3.adjust_hue(10)}"
end

def hsl_examples
  puts "\n# HSL examples"
  eg1 = Color::HSL.from_values(90, 30, 50)
  puts "Color::HSL.from_values(90, 30, 50)                : #{eg1}"

  eg2 = Color::HSL.new(h: 0.25, s: 0.6, l: 0.8)
  puts "Color::HSL.new(h: 0.25, s: 0.6, l: 0.8)           : #{eg2}"

  eg3 = Color::HSL.new(0.25, 0.6, 0.8)
  puts "Color::HSL.new(0.25, 0.6, 0.8)                    : #{eg3}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).inspect            : #{eg3.inspect}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_h               : #{eg3.to_h}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_a               : #{eg3.to_a}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).h                  : #{eg3.h}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).hue                : #{eg3.hue}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).s                  : #{eg3.s}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).saturation         : #{eg3.saturation}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).l                  : #{eg3.l}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).luminosity         : #{eg3.luminosity}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).brightness         : #{eg3.brightness}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_cmyk            : #{eg3.to_cmyk}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_grayscale       : #{eg3.to_grayscale}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_lab             : #{eg3.to_lab}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_rgb             : #{eg3.to_rgb}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_xyz             : #{eg3.to_xyz}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_yiq             : #{eg3.to_yiq}"
  puts "Color::HSL.new(0.25, 0.6, 0.8).to_internal        : #{eg3.to_internal}"
end

def cmyk_examples
  puts "\n# CMYK examples"
  eg1 = Color::CMYK.from_values(30, 0, 80, 30)
  puts "Color::CMYK.from_values(30, 0, 80, 30)            : #{eg1}"

  eg2 = Color::CMYK.new(c: 0.3, m: 0, y: 0.8, k: 0.3)
  puts "Color::CMYK.new(c: 0.3, m: 0, y: 0.8, k: 0.3)     : #{eg2}"

  eg3 = Color::CMYK.new(0.3, 0, 0.8, 0.3)
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3)                 : #{eg3}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).inspect         : #{eg3.inspect}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_h            : #{eg3.to_h}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_a            : #{eg3.to_a}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).c               : #{eg3.c}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).cyan            : #{eg3.cyan}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).m               : #{eg3.m}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).magenta         : #{eg3.magenta}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).y               : #{eg3.y}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).yellow          : #{eg3.yellow}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).k               : #{eg3.k}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).key             : #{eg3.key}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).b               : #{eg3.b}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).black           : #{eg3.black}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).css             : #{eg3.css}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_grayscale    : #{eg3.to_grayscale}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_hsl          : #{eg3.to_hsl}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_lab          : #{eg3.to_lab}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_rgb          : #{eg3.to_rgb}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_xyz          : #{eg3.to_xyz}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_yiq          : #{eg3.to_yiq}"
  puts "Color::CMYK.new(0.3, 0, 0.8, 0.3).to_internal     : #{eg3.to_internal}"
end

def lab_examples
  puts "\n# CIELAB examples"
  eg1 = Color::CIELAB.from_values(10, 35, -35)
  puts "Color::CIELAB.from_values(10, 35, -35)            : #{eg1}"

  eg2 = Color::CIELAB.new(l: 10, a: 35, b: -35)
  puts "Color::CIELAB.new(l: 10, a: 35, b: -35)           : #{eg2}"

  eg3 = Color::CIELAB.new(10, 35, -35)
  puts "Color::CIELAB.new(10, 35, -35)                    : #{eg3}"
  puts "Color::CIELAB.new(10, 35, -35).inspect            : #{eg3.inspect}"
  puts "Color::CIELAB.new(10, 35, -35).to_h               : #{eg3.to_h}"
  puts "Color::CIELAB.new(10, 35, -35).to_a               : #{eg3.to_a}"
  puts "Color::CIELAB.new(10, 35, -35).l                  : #{eg3.l}"
  puts "Color::CIELAB.new(10, 35, -35).a                  : #{eg3.a}"
  puts "Color::CIELAB.new(10, 35, -35).b                  : #{eg3.b}"
  puts "Color::CIELAB.new(10, 35, -35).css                : #{eg3.css}"
  puts "Color::CIELAB.new(10, 35, -35).to_cmyk            : #{eg3.to_cmyk}"
  puts "Color::CIELAB.new(10, 35, -35).to_grayscale       : #{eg3.to_grayscale}"
  puts "Color::CIELAB.new(10, 35, -35).to_hsl             : #{eg3.to_hsl}"
  puts "Color::CIELAB.new(10, 35, -35).to_rgb             : #{eg3.to_rgb}"
  puts "Color::CIELAB.new(10, 35, -35).to_xyz             : #{eg3.to_xyz}"
  puts "Color::CIELAB.new(10, 35, -35).to_yiq             : #{eg3.to_yiq}"
  puts "Color::CIELAB.new(10, 35, -35).to_internal        : #{eg3.to_internal}"
  puts "Color::CIELAB.new(10, 35, -35).delta_e2000(Color::RGB.from_html('#0000FF')) : #{eg3.delta_e2000(Color::RGB.from_html('#0000FF'))}"
  puts "Color::CIELAB.new(10, 35, -35).delta_e94(Color::RGB.from_html('#0000FF')) : #{eg3.delta_e94(Color::RGB.from_html('#0000FF'))}"
end

def grayscale_examples
  puts "\n# Grayscale examples"
  eg1 = Color::Grayscale.from_values(50)
  puts "Color::Grayscale.from_values(50)                  : #{eg1}"

  eg2 = Color::Grayscale.new(g: 0.5)
  puts "Color::Grayscale.new(g: 0.5)                      : #{eg2}"

  eg3 = Color::Grayscale.new(0.5)
  puts "Color::Grayscale.new(0.5)                         : #{eg3}"
  puts "Color::Grayscale.new(0.5).inspect                 : #{eg3.inspect}"
  puts "Color::Grayscale.new(0.5).to_h                    : #{eg3.to_h}"
  puts "Color::Grayscale.new(0.5).to_a                    : #{eg3.to_a}"
  puts "Color::Grayscale.new(0.5).g                       : #{eg3.g}"
  puts "Color::Grayscale.new(0.5).gray                    : #{eg3.gray}"
  puts "Color::Grayscale.new(0.5).brightness              : #{eg3.brightness}"
  puts "Color::Grayscale.new(0.5).css                     : #{eg3.css}"
  puts "Color::Grayscale.new(0.5).to_cmyk                 : #{eg3.to_cmyk}"
  puts "Color::Grayscale.new(0.5).to_hsl                  : #{eg3.to_hsl}"
  puts "Color::Grayscale.new(0.5).to_lab                  : #{eg3.to_lab}"
  puts "Color::Grayscale.new(0.5).to_rgb                  : #{eg3.to_rgb}"
  puts "Color::Grayscale.new(0.5).to_xyz                  : #{eg3.to_xyz}"
  puts "Color::Grayscale.new(0.5).to_yiq                  : #{eg3.to_yiq}"
  puts "Color::Grayscale.new(0.5).to_internal             : #{eg3.to_internal}"
  puts "Color::Grayscale.new(0.5).lighten_by(20)          : #{eg3.lighten_by(20)}"
  puts "Color::Grayscale.new(0.5).darken_by(20)           : #{eg3.darken_by(20)}"
end

def xyz_examples
  puts "\n# XYZ examples"
  eg1 = Color::XYZ.from_values(95.047, 100.00, 108.883)
  puts "Color::XYZ.from_values(95.047, 100.00, 108.883)   : #{eg1}"

  eg2 = Color::XYZ.new(x: 0.95047, y: 1.0, z: 1.08883)
  puts "Color::XYZ.new(x: 0.95047, y: 1.0, z: 1.08883)    : #{eg2}"

  eg3 = Color::XYZ.new(0.95047, 1.0, 1.08883)
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883)             : #{eg3}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).inspect     : #{eg3.inspect}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_h        : #{eg3.to_h}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_a        : #{eg3.to_a}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).x           : #{eg3.x}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).y           : #{eg3.y}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).z           : #{eg3.z}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_cmyk     : #{eg3.to_cmyk}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_grayscale: #{eg3.to_grayscale}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_hsl      : #{eg3.to_hsl}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_lab      : #{eg3.to_lab}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_rgb      : #{eg3.to_rgb}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_yiq      : #{eg3.to_yiq}"
  puts "Color::XYZ.new(0.95047, 1.0, 1.08883).to_internal : #{eg3.to_internal}"
end

def yiq_examples
  puts "\n# YIQ examples"
  eg1 = Color::YIQ.from_values(30, 20, 10)
  puts "Color::YIQ.from_values(30, 20, 10)                : #{eg1}"

  eg2 = Color::YIQ.new(y: 0.3, i: 0.2, q: 0.1)
  puts "Color::YIQ.new(y: 0.3, i: 0.2, q: 0.1)            : #{eg2}"

  eg3 = Color::YIQ.new(0.3, 0.2, 0.1)
  puts "Color::YIQ.new(0.3, 0.2, 0.1)                     : #{eg3}"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).inspect             : #{eg3.inspect}"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).to_h                : #{eg3.to_h}"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).to_a                : #{eg3.to_a}"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).y                   : #{eg3.y}"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).i                   : #{eg3.i}"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).q                   : #{eg3.q}"
  # puts "Color::YIQ.new(0.3, 0.2, 0.1).to_cmyk             : #{eg3.to_cmyk} NYI"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).to_grayscale        : #{eg3.to_grayscale}"
  # puts "Color::YIQ.new(0.3, 0.2, 0.1).to_hsl              : #{eg3.to_hsl} NYI"
  # puts "Color::YIQ.new(0.3, 0.2, 0.1).to_lab              : #{eg3.to_lab} NYI"
  # puts "Color::YIQ.new(0.3, 0.2, 0.1).to_rgb              : #{eg3.to_rgb} NYI"
  # puts "Color::YIQ.new(0.3, 0.2, 0.1).to_xyz              : #{eg3.to_xyz} NYI"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).to_yiq              : #{eg3.to_yiq}"
  puts "Color::YIQ.new(0.3, 0.2, 0.1).to_internal         : #{eg3.to_internal}"
end

rgb_examples
hsl_examples
lab_examples
cmyk_examples
grayscale_examples
xyz_examples
yiq_examples
