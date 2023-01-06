#! /usr/bin/env ruby
require 'rubyvis'
require 'RMagick'

def generate(chart_type)
  chart = send(chart_type)
  output_svg = "#{chart_type}.svg"
  puts "Save to: #{output_svg}"
  svg_string = chart.to_svg
  File.write(output_svg, svg_string)

  save_svg_as_png(svg_string, "#{chart_type}.png")
end

def save_svg_as_png(svg_string, filename)
  img = Magick::Image.from_blob(svg_string) do |info|
    info.format = 'SVG'
    info.background_color = 'transparent'
  end
  img.first.write filename
end

def line_chart
  data = pv.range(0, 10, 0.1).map {|x|
    OpenStruct.new({:x=> x, :y=> Math.sin(x) + 2+rand()})
  }

  #p data
  w = 400
  h = 200
  x = pv.Scale.linear(data, lambda {|d| d.x}).range(0, w)
  y = pv.Scale.linear(data, lambda {|d| d.y}).range(0, h)

  vis = pv.Panel.new()
    .width(w)
    .height(h)
    .bottom(20)
    .left(20)
    .right(10)
    .top(5)

  vis.add(pv.Line).
    data(data).
    line_width(5).
    left(lambda {|d| x.scale(d.x)}).
    bottom(lambda {|d| y.scale(d.y)}).
    anchor("bottom").add(pv.Line).
      stroke_style('red').
      line_width(1)

  vis.render();
  vis
end

generate('line_chart')
