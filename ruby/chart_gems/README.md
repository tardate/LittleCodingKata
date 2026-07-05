# #250 Chart Gems

Notes on ruby options for chart generation that support output as an image

## Notes

These are my notes on ruby options for chart generation, specifically:

* supporting common chart types (line, column, bar, pie, XY)
* supporting multiple data series
* with customizable chart decoration (titles, axis, tick marks etc)
* and supporting output to image file or data stream (bitmap or vector) i.e. not for web rendering
* supporting ruby 2.7.2 or above on macOS and Linux
* ideally no additional non-ruby dependencies

Trawling for options:

* [ruby-toolbox](https://www.ruby-toolbox.com/categories/graphing)
* [rubygems](https://rubygems.org/search?query=chart)
* even asked [ChatGPT](https://chat.openai.com/) - it recommended gruff

### Legacy Google Image Charts API

The [Google Image Charts API](https://developers.google.com/chart/image/)
is used to dynamically generate charts with a URL string.

The API was deprecated in 2012 and was retired on March 18, 2019. It is still running and working.
However note the warning from Google that it may disappear any day:

> While the dynamic and interactive [Google Charts](https://developers.google.com/chart) are actively maintained, we officially deprecated the static Google Image Charts way back in 2012. This gives us the right to turn it off without notice, which may happen soon.

There were a number of Ruby gems created to take advantage of the service. They all still work as of Jan 2023.

Note: the new [Google Charts](https://developers.google.com/chart) service doesn't meet my requirement for non-interactive generation.
However to use Google Charts, there are gems for that e.g.:

* [google_visualr](https://rubygems.org/gems/google_visualr) is a wrapper around the Google Chart Tools that allows anyone to create the same beautiful charts with just Ruby; you don't have to write any JavaScript at all.
* [chartkick](https://rubygems.org/gems/chartkick) - Create beautiful JavaScript charts with one line of Ruby. Supports Google Charts, Highcharts and Chart.js

#### gchartrb

The [gchartrb](https://rubygems.org/gems/gchartrb) gem is the ancient and original wrapper for the Google Image Charts API,
hosted on [Google Code](https://code.google.com/archive/p/gchartrb/).

It has not been maintained since 2008, but it does still work. It generates HTTP requests, but the Google Image Charts API automatically redirects these to be handled over HTTPS.

A simple [example.rb](./using_gchartrb/example.rb) generates graphs like this:

![line_chart](./using_gchartrb/line_chart.png?raw=true)

#### gchart

The [gchart](https://rubygems.org/gems/gchart) gem arrived at around the same time as gchartrb as one of the first
community-supported wrappers for the Google Chart API.

After the RubyForge shutdown, the code was migrated to [github](https://github.com/abhay/gchart)

It has not been maintained since 2009, as community focus appears to have shifted to the googlecharts gem.

A simple [example.rb](./using_gchart/example.rb) generates graphs like this:

![line_chart](./using_gchart/line_chart.png?raw=true)

#### googlecharts

The [googlecharts](https://rubygems.org/gems/googlecharts) gem also arrived at around the same time as gchartrb as one of the first
community-supported wrappers for the Google Chart API.

After the RubyForge shutdown, the code was migrated to [github](https://github.com/mattetti/googlecharts),
but it has ceased to be maintained since 2015 and is now archived.

A simple [example.rb](./using_googlecharts/example.rb) generates graphs like this:

![line_chart](./using_googlecharts/line_chart.png?raw=true)

### ruby-graphviz

The [ruby-graphviz](https://rubygems.org/gems/ruby-graphviz) gem provides an interface to layout and generate images of directed graphs in a variety of formats (PostScript, PNG, etc.) using GraphViz.

It requires [Graphviz](http://www.graphviz.org/download/) to be installed.

For testing on Mac I used brew: `brew install graphviz`.
.. I ran into issues with that (some source repos not having valid SSL certs etc) so I've abandoned this test for now...

### gruff

The [gruff](https://rubygems.org/gems/gruff) gem
Requires [rmagick](https://github.com/rmagick/rmagick)

A simple [example.rb](./using_gruff/example.rb) generates graphs like this:

![line_chart](./using_gruff/line_chart.png?raw=true)

### rubyvis

The [rubyvis](https://rubygems.org/gems/rubyvis) gem is a Ruby port of Protovis, a Javascript visualization toolkit.
Pure ruby.

A simple [example.rb](./using_rubyvis/example.rb) generates graphs like this as SVG:

![line_chart](./using_rubyvis/line_chart.svg?raw=true)

Converted to PNG using [rmagick](https://github.com/rmagick/rmagick):

![line_chart.png](./using_rubyvis/line_chart.png?raw=true)

## Credits and References

* [Google Image Charts API](https://developers.google.com/chart/image/)
* [Google Charts](https://developers.google.com/chart) - Javascript-based successor to Google Image Charts
* [gchartrb](https://rubygems.org/gems/gchartrb) Google Chart URLs
* [gchart](https://rubygems.org/gems/gchart) GChart exposes the Google Chart API via a friendly Ruby interface - [github](https://github.com/abhay/gchart)
* [googlecharts](https://rubygems.org/gems/googlecharts) Ruby Google Chart API - [github](https://github.com/mattetti/googlecharts)
* [ruby-graphviz](https://rubygems.org/gems/ruby-graphviz)
* [gruff](https://rubygems.org/gems/gruff)
* [rubyvis](https://rubygems.org/gems/rubyvis)
