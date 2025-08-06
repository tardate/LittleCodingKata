# #345 Color tools for Ruby

A quick look at the color gem: a Ruby library used to represent colors in a range of color models and offer color space manipulation support to applications that require it.

## Notes

Capabilities:

* supported color models: RGB, CIELAB, CMYK, HSL, Grayscale, XYZ, YIQ
* conversion between color models
* optional named RGB colors for HTML, SVG, and X11 applications
* CIELAB [perceptual color distance metric](https://en.wikipedia.org/wiki/Color_difference) calculation:
    * CIELAB ΔE* 2000
    * CIELAB ΔE* 1994
* CIELAB to Color::XYZ based on a reference white
    * Color provides D65 and D50 reference white values in Color::XYZ

The Color library performs purely mathematical manipulation of the colors based on color theory without reference to device color profiles such as [sRGB](https://en.wikipedia.org/wiki/SRGB) or [Adobe RGB (opRGB)](https://en.wikipedia.org/wiki/Adobe_RGB_color_space)

### RGB

The [RGB](https://en.wikipedia.org/wiki/RGB_color_model) color model is an additive color model where the primary colors (red, green,
and blue) of light are added to produce millions of colors. RGB rendering is
device-dependent and without color management, the same "red" color will render
differently.

This class does not implement color management and is not RGB color space aware; that is, unless otherwise noted, it does not assume that the RGB represented is
[sRGB](https://en.wikipedia.org/wiki/SRGB) or
[Adobe RGB (opRGB)](https://en.wikipedia.org/wiki/Adobe_RGB_color_space).

Construction examples:

```ruby
Color::RGB.new(0.2, 1.0, 0.4)
Color::RGB.new(r: 0.2, g: 1.0, b: 0.4)
Color::RGB.from_html('#33ff66')
Color::RGB.from_values(51, 255, 102)
```

Special features:

* `Color::RGB::x` named colors
* `delta_e2000(other)`
* `delta_e94(other)`
* `lighten_by(percent)`
* `darken_by(percent)`
* `mix_with(mask, opacity)`
* `adjust_brightness(percent)`
* `adjust_saturation(percent)`
* `adjust_hue(percent)`
* `closest_match`
* `max_rgb_as_grayscale`

### CMYK

The [CMYK](https://en.wikipedia.org/wiki/CMYK_color_model) color model is a subtractive color model based on additive percentages of
colored inks: cyan, magenta, yellow, and key (most often black).
CMYK [30% 0% 80% 30%] would be mixed from 30% cyan, 0% magenta, 80% yellow, and 30%
black.

Construction examples:

```ruby
Color::CMYK.new(0.3, 0.0, 0.8, 0.3)
Color::CMYK.new(c: 0.3, m: 0.0, y: 0.8, k: 0.3)
Color::CMYK.from_values(30, 0, 80, 30)
```

### CIELAB

A Color object for the
[CIELAB](https://en.wikipedia.org/wiki/CIELAB_color_space)
color space (also known as Lab). Color is
expressed in a three-dimensional, device-independent "standard observer" model, often
in relation to a "reference white" color, usually Color::XYZ::D65 (most purposes) or
Color::XYZ::D50 (printing).

* `L*` is the perceptual lightness, bounded to values between 0 (black) and 100 (white).
* `a*` is the range of green (negative) / red (positive)
* `b*` is the range of blue (negative) / yellow (positive).

The `a*` and `b*` ranges are _technically_ unbounded but Color clamps them to the values `-128..127`.

Construction examples:

```ruby
Color::CIELAB.new(10, 35, -35)
Color::CIELAB.new(l: 10, a: 35, b: -35)
Color::CIELAB.from_values(10, 35, -35)
```

Special features:

* `delta_e2000`
* `delta_e94`

### HSL

The [HSL](https://en.wikipedia.org/wiki/HSL_and_HSV) color model is a cylindrical-coordinate representation of the sRGB color model,
standing for hue (measured in degrees on the cylinder), saturation (measured in
percentage), and lightness (measured in percentage).

Construction examples:

```ruby
Color::HSL.new(0.25, 0.3, 0.5)
Color::HSL.from_values(90, 30, 50)
```

### Grayscale

Grayscale is a color object representing shades of gray as a ratio of black to white,
where 0% (0.0) gray is black and 100% (1.0) gray is white.

Construction examples:

```ruby
Color::Grayscale.new(0.5)
Color::Grayscale.from_values(50)
```

Special features:

* `lighten_by(percent)`
* `darken_by(percent)`

### XYZ

A Color object for the [CIE 1931 XYZ](https://en.wikipedia.org/wiki/CIE_1931_color_space#CIE_XYZ_color_space) color space derived from the original CIE RGB
color space as linear transformation functions x̅(λ), y̅(λ), and z̅(λ) that describe the
device-independent CIE standard observer. It underpins most other CIE color systems
(such as CIELAB), but is directly used mostly for color instrument readings and color
space transformations particularly in color profiles.
The XYZ color space ranges describe the mixture of wavelengths of light required to
stimulate cone cells in the human eye, as well as the luminance (brightness) required.
The `Y` component describes the luminance while the `X` and `Z` components describe two
axes of chromaticity. Definitionally, the minimum value for any XYZ color component is
0.
As XYZ describes imaginary colors, the color gamut is usually expressed in relation to
a reference white of an illuminant (frequently often D65 or D50) and expressed as the
`xyY` color space, computed as:

```math
x = X / (X + Y + Z)
y = Y / (X + Y + Z)
Y = Y
```

The range of `Y` values is conventionally clamped to 0..100, whereas the `X` and `Z`
values must be no lower than 0 and on the same scale.

Construction examples:

```ruby
Color::XYZ.from_values(95.047, 100.00, 108.883)
Color::XYZ.from_values(x: 95.047, y: 100.00, z: 108.883)
Color::XYZ.new(0.95047, 1.0, 1.08883)
```

### YIQ

A Color object representing [YIQ](https://en.wikipedia.org/wiki/YIQ) (NTSC) color encoding, where Y is the luma
(brightness) value, and I (orange-blue) and Q (purple-green) are chrominance.
All values are clamped between 0 and 1 inclusive.

YIQ is only partially implemented: other Color objects can only be converted _to_
YIQ, but it has few conversion functions for converting _from_ YIQ.

Construction examples:

```ruby
Color::YIQ.new(0.3, 0.2, 0.1)
Color::YIQ.from_values(30, 20, 10)
```

### Example

See [examples.rb](./examples.rb) for a quick play with the library:

```sh
$ ./examples.rb

# RGB examples
Color::RGB.from_html('#0000FF')                   : #<data Color::RGB r=0.0, g=0.0, b=1.0, names=nil>
Color::RGB.from_values(51, 255, 102)              : #<data Color::RGB r=0.2, g=1.0, b=0.4, names=nil>
Color::RGB.from_values(51, 255, 102).hex          : 33ff66
Color::RGB.new(r: 1.0, g: 0.2, b: 0.45)           : #<data Color::RGB r=1.0, g=0.2, b=0.45, names=nil>
Color::RGB::Blue                                  : #<data Color::RGB r=0.0, g=0.0, b=1.0, names=["blue"]>
Color::RGB.new(1.0, 0.2, 0.45)                    : #<data Color::RGB r=1.0, g=0.2, b=0.45, names=nil>
Color::RGB.new(1.0, 0.2, 0.45).inspect            : RGB [#ff3373]
Color::RGB.new(1.0, 0.2, 0.45).to_h               : {:r=>1.0, :g=>0.2, :b=>0.45, :names=>nil}
Color::RGB.new(1.0, 0.2, 0.45).to_a               : [255.0, 51.0, 114.75]
Color::RGB.new(1.0, 0.2, 0.45).r                  : 1.0
Color::RGB.new(1.0, 0.2, 0.45).red                : 255.0
Color::RGB.new(1.0, 0.2, 0.45).g                  : 0.2
Color::RGB.new(1.0, 0.2, 0.45).green              : 51.0
Color::RGB.new(1.0, 0.2, 0.45).b                  : 0.45
Color::RGB.new(1.0, 0.2, 0.45).blue               : 114.75
Color::RGB.new(1.0, 0.2, 0.45).hex                : ff3373
Color::RGB.new(1.0, 0.2, 0.45).html               : #ff3373
Color::RGB.new(1.0, 0.2, 0.45).css                : rgb(100.00% 20.00% 45.00%)
Color::RGB.new(1.0, 0.2, 0.45).to_cmyk            : #<data Color::CMYK c=0.0, m=0.8, y=0.55, k=0.0>
Color::RGB.new(1.0, 0.2, 0.45).to_grayscale       : #<data Color::Grayscale g=0.6>
Color::RGB.new(1.0, 0.2, 0.45).to_hsl             : #<data Color::HSL h=0.9479166666666666, s=1.0, l=0.6>
Color::RGB.new(1.0, 0.2, 0.45).to_lab             : #<data Color::CIELAB l=56.94503080811005, a=76.74737744142817, b=14.904898010190104>
Color::RGB.new(1.0, 0.2, 0.45).to_xyz             : #<data Color::XYZ x=0.45508461892804625, y=0.24866414488614244, z=0.1854443054868735>
Color::RGB.new(1.0, 0.2, 0.45).to_yiq             : #<data Color::YIQ y=0.4677, i=0.39654999999999996, q=0.24734999999999996>
Color::RGB.new(1.0, 0.2, 0.45).to_internal        : [1.0, 0.2, 0.45]
Color::RGB.new(1.0, 0.2, 0.45).darken_by(10)      : #<data Color::RGB r=0.1, g=0.020000000000000004, b=0.045000000000000005, names=nil>
Color::RGB.new(1.0, 0.2, 0.45).lighten_by(10)     : #<data Color::RGB r=1.0, g=0.92, b=0.9450000000000001, names=nil>
Color::RGB.new(1.0, 0.2, 0.45).adjust_brightness(10) : #<data Color::RGB r=1.0, g=0.32000000000000006, b=0.5325000000000002, names=nil>
Color::RGB.new(1.0, 0.2, 0.45).adjust_saturation(10) : #<data Color::RGB r=1.0, g=0.19999999999999996, b=0.4500000000000002, names=nil>
Color::RGB.new(1.0, 0.2, 0.45).adjust_hue(10)     : #<data Color::RGB r=1.0, g=0.19999999999999996, b=0.19999999999999943, names=nil>

# HSL examples
Color::HSL.from_values(90, 30, 50)                : #<data Color::HSL h=0.25, s=0.3, l=0.5>
Color::HSL.new(h: 0.25, s: 0.6, l: 0.8)           : #<data Color::HSL h=0.25, s=0.6, l=0.8>
Color::HSL.new(0.25, 0.6, 0.8)                    : #<data Color::HSL h=0.25, s=0.6, l=0.8>
Color::HSL.new(0.25, 0.6, 0.8).inspect            : HSL [90.00deg 60.00% 80.00%]
Color::HSL.new(0.25, 0.6, 0.8).to_h               : {:h=>0.25, :s=>0.6, :l=>0.8}
Color::HSL.new(0.25, 0.6, 0.8).to_a               : [90.0, 60.0, 80.0]
Color::HSL.new(0.25, 0.6, 0.8).h                  : 0.25
Color::HSL.new(0.25, 0.6, 0.8).hue                : 90.0
Color::HSL.new(0.25, 0.6, 0.8).s                  : 0.6
Color::HSL.new(0.25, 0.6, 0.8).saturation         : 60.0
Color::HSL.new(0.25, 0.6, 0.8).l                  : 0.8
Color::HSL.new(0.25, 0.6, 0.8).luminosity         : 80.0
Color::HSL.new(0.25, 0.6, 0.8).brightness         : 0.8
Color::HSL.new(0.25, 0.6, 0.8).to_cmyk            : #<data Color::CMYK c=0.18854079999999995, m=0.06854080000000005, y=0.30854079999999984, k=0.011459200000000017>
Color::HSL.new(0.25, 0.6, 0.8).to_grayscale       : #<data Color::Grayscale g=0.8>
Color::HSL.new(0.25, 0.6, 0.8).to_lab             : #<data Color::CIELAB l=89.41981423782663, a=-20.580380391075238, b=26.48851021744585>
Color::HSL.new(0.25, 0.6, 0.8).to_rgb             : #<data Color::RGB r=0.8, g=0.9199999999999999, b=0.6800000000000002, names=nil>
Color::HSL.new(0.25, 0.6, 0.8).to_xyz             : #<data Color::XYZ x=0.6207617569276594, y=0.7505727138541277, z=0.5094735161723772>
Color::HSL.new(0.25, 0.6, 0.8).to_yiq             : #<data Color::YIQ y=0.85676, i=0.005519999999999942, q=0.0>
Color::HSL.new(0.25, 0.6, 0.8).to_internal        : [0.25, 0.6, 0.8]

# CIELAB examples
Color::CIELAB.from_values(10, 35, -35)            : #<data Color::CIELAB l=10, a=35, b=-35>
Color::CIELAB.new(l: 10, a: 35, b: -35)           : #<data Color::CIELAB l=10, a=35, b=-35>
Color::CIELAB.new(10, 35, -35)                    : #<data Color::CIELAB l=10, a=35, b=-35>
Color::CIELAB.new(10, 35, -35).inspect            : CIELAB [10.0000 35.0000 -35.0000]
Color::CIELAB.new(10, 35, -35).to_h               : {:l=>10, :a=>35, :b=>-35}
Color::CIELAB.new(10, 35, -35).to_a               : [10, 35, -35]
Color::CIELAB.new(10, 35, -35).l                  : 10
Color::CIELAB.new(10, 35, -35).a                  : 35
Color::CIELAB.new(10, 35, -35).b                  : -35
Color::CIELAB.new(10, 35, -35).css                : lab(10.00% 35.00 -35.00)
Color::CIELAB.new(10, 35, -35).to_cmyk            : #<data Color::CMYK c=0.18447093262606185, m=0.3548205599469607, y=0.06411107916518433, k=0.6379344598202296>
Color::CIELAB.new(10, 35, -35).to_grayscale       : #<data Color::Grayscale g=0.15259972062369795>
Color::CIELAB.new(10, 35, -35).to_hsl             : #<data Color::HSL h=0.7643298198501555, s=0.9525229783960389, l=0.15259972062369795>
Color::CIELAB.new(10, 35, -35).to_rgb             : #<data Color::RGB r=0.17759460755370857, g=0.007244980232809748, b=0.29795446101458617, names=nil>
Color::CIELAB.new(10, 35, -35).to_xyz             : #<data Color::XYZ x=0.024186512981709044, y=0.01126019927016278, z=0.06923404515364971>
Color::CIELAB.new(10, 35, -35).to_internal        : [10, 35, -35]
Color::CIELAB.new(10, 35, -35).delta_e2000(Color::RGB.from_html('#0000FF')) : 24.118528112469036
Color::CIELAB.new(10, 35, -35).delta_e94(Color::RGB.from_html('#0000FF')) : 35.07142143308636

# CMYK examples
Color::CMYK.from_values(30, 0, 80, 30)            : #<data Color::CMYK c=0.3, m=0.0, y=0.8, k=0.3>
Color::CMYK.new(c: 0.3, m: 0, y: 0.8, k: 0.3)     : #<data Color::CMYK c=0.3, m=0.0, y=0.8, k=0.3>
Color::CMYK.new(0.3, 0, 0.8, 0.3)                 : #<data Color::CMYK c=0.3, m=0.0, y=0.8, k=0.3>
Color::CMYK.new(0.3, 0, 0.8, 0.3).inspect         : CMYK [30.00% 0.00% 80.00% 30.00%]
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_h            : {:c=>0.3, :m=>0.0, :y=>0.8, :k=>0.3}
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_a            : [30.0, 0.0, 80.0, 30.0]
Color::CMYK.new(0.3, 0, 0.8, 0.3).c               : 0.3
Color::CMYK.new(0.3, 0, 0.8, 0.3).cyan            : 30.0
Color::CMYK.new(0.3, 0, 0.8, 0.3).m               : 0.0
Color::CMYK.new(0.3, 0, 0.8, 0.3).magenta         : 0.0
Color::CMYK.new(0.3, 0, 0.8, 0.3).y               : 0.8
Color::CMYK.new(0.3, 0, 0.8, 0.3).yellow          : 80.0
Color::CMYK.new(0.3, 0, 0.8, 0.3).k               : 0.3
Color::CMYK.new(0.3, 0, 0.8, 0.3).key             : 30.0
Color::CMYK.new(0.3, 0, 0.8, 0.3).b               : 0.3
Color::CMYK.new(0.3, 0, 0.8, 0.3).black           : 30.0
Color::CMYK.new(0.3, 0, 0.8, 0.3).css             : device-cmyk(30.00% 0 80.00% 30.00%, rgb(49.00% 70.00% 14.00%))
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_grayscale    : #<data Color::Grayscale g=0.5191>
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_hsl          : #<data Color::HSL h=0.22916666666666666, s=0.6666666666666664, l=0.42000000000000004>
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_lab          : #<data Color::CIELAB l=66.91625392756802, a=-37.95899860362956, b=61.38322781498079>
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_rgb          : #<data Color::RGB r=0.49, g=0.7, b=0.14000000000000012, names=nil>
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_xyz          : #<data Color::XYZ x=0.24784064044701537, y=0.36521201007079285, z=0.07388312039323361>
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_yiq          : #<data Color::YIQ y=0.5733699999999999, i=0.05459999999999992, q=0.0>
Color::CMYK.new(0.3, 0, 0.8, 0.3).to_internal     : [0.3, 0.0, 0.8, 0.3]

# Grayscale examples
Color::Grayscale.from_values(50)                  : #<data Color::Grayscale g=0.5>
Color::Grayscale.new(g: 0.5)                      : #<data Color::Grayscale g=0.5>
Color::Grayscale.new(0.5)                         : #<data Color::Grayscale g=0.5>
Color::Grayscale.new(0.5).inspect                 : Grayscale [50.00%]
Color::Grayscale.new(0.5).to_h                    : {:g=>0.5}
Color::Grayscale.new(0.5).to_a                    : [50.0]
Color::Grayscale.new(0.5).g                       : 0.5
Color::Grayscale.new(0.5).gray                    : 50.0
Color::Grayscale.new(0.5).brightness              : 0.5
Color::Grayscale.new(0.5).css                     : rgb(50.00% 50.00% 50.00%)
Color::Grayscale.new(0.5).to_cmyk                 : #<data Color::CMYK c=0.0, m=0.0, y=0.0, k=0.5>
Color::Grayscale.new(0.5).to_hsl                  : #<data Color::HSL h=0.0, s=0.0, l=0.5>
Color::Grayscale.new(0.5).to_lab                  : #<data Color::CIELAB l=53.38896705407974, a=0.004180380146878715, b=-0.00085701884331435>
Color::Grayscale.new(0.5).to_rgb                  : #<data Color::RGB r=0.5, g=0.5, b=0.5, names=nil>
Color::Grayscale.new(0.5).to_yiq                  : #<data Color::YIQ y=0.5, i=0.0, q=0.0>
Color::Grayscale.new(0.5).to_internal             : [0.5]
Color::Grayscale.new(0.5).lighten_by(20)          : #<data Color::Grayscale g=0.6>
Color::Grayscale.new(0.5).darken_by(20)           : #<data Color::Grayscale g=0.4>

# XYZ examples
Color::XYZ.from_values(95.047, 100.00, 108.883)   : #<data Color::XYZ x=0.9504699999999999, y=1.0, z=1.08883>
Color::XYZ.new(x: 0.95047, y: 1.0, z: 1.08883)    : #<data Color::XYZ x=0.95047, y=1.0, z=1.08883>
Color::XYZ.new(0.95047, 1.0, 1.08883)             : #<data Color::XYZ x=0.95047, y=1.0, z=1.08883>
Color::XYZ.new(0.95047, 1.0, 1.08883).inspect     : XYZ [0.95047 1.0 1.08883]
Color::XYZ.new(0.95047, 1.0, 1.08883).to_h        : {:x=>0.95047, :y=>1.0, :z=>1.08883}
Color::XYZ.new(0.95047, 1.0, 1.08883).to_a        : [95.047, 100.0, 108.883]
Color::XYZ.new(0.95047, 1.0, 1.08883).x           : 0.95047
Color::XYZ.new(0.95047, 1.0, 1.08883).y           : 1.0
Color::XYZ.new(0.95047, 1.0, 1.08883).z           : 1.08883
Color::XYZ.new(0.95047, 1.0, 1.08883).to_cmyk     : #<data Color::CMYK c=0.0, m=0.0, y=0.0, k=0.0>
Color::XYZ.new(0.95047, 1.0, 1.08883).to_grayscale: #<data Color::Grayscale g=1.0>
Color::XYZ.new(0.95047, 1.0, 1.08883).to_hsl      : #<data Color::HSL h=0.0, s=0.0, l=1.0>
Color::XYZ.new(0.95047, 1.0, 1.08883).to_lab      : #<data Color::CIELAB l=100.0, a=0.007005156822281755, b=-0.0014393755445318845>
Color::XYZ.new(0.95047, 1.0, 1.08883).to_rgb      : #<data Color::RGB r=1.0, g=1.0, b=1.0, names=nil>
Color::XYZ.new(0.95047, 1.0, 1.08883).to_yiq      : #<data Color::YIQ y=1.0, i=0.0, q=0.0>
Color::XYZ.new(0.95047, 1.0, 1.08883).to_internal : [0.95047, 1.0, 1.08883]

# YIQ examples
Color::YIQ.from_values(30, 20, 10)                : #<data Color::YIQ y=0.3, i=0.2, q=0.1>
Color::YIQ.new(y: 0.3, i: 0.2, q: 0.1)            : #<data Color::YIQ y=0.3, i=0.2, q=0.1>
Color::YIQ.new(0.3, 0.2, 0.1)                     : #<data Color::YIQ y=0.3, i=0.2, q=0.1>
Color::YIQ.new(0.3, 0.2, 0.1).inspect             : YIQ [30.00% 20.00% 10.00%]
Color::YIQ.new(0.3, 0.2, 0.1).to_h                : {:y=>0.3, :i=>0.2, :q=>0.1}
Color::YIQ.new(0.3, 0.2, 0.1).to_a                : [0.3, 0.2, 0.1]
Color::YIQ.new(0.3, 0.2, 0.1).y                   : 0.3
Color::YIQ.new(0.3, 0.2, 0.1).i                   : 0.2
Color::YIQ.new(0.3, 0.2, 0.1).q                   : 0.1
Color::YIQ.new(0.3, 0.2, 0.1).to_grayscale        : #<data Color::Grayscale g=0.3>
Color::YIQ.new(0.3, 0.2, 0.1).to_yiq              : #<data Color::YIQ y=0.3, i=0.2, q=0.1>
Color::YIQ.new(0.3, 0.2, 0.1).to_internal         : [0.3, 0.2, 0.1]
```

## Credits and References

* <https://github.com/halostatue/color>
* <https://rubygems.org/gems/color>
* <https://www.rubydoc.info/gems/color>
* <https://en.wikipedia.org/wiki/CIELAB_color_space>
* <https://en.wikipedia.org/wiki/HSL_and_HSV>
* <https://en.wikipedia.org/wiki/RGB_color_model>
* <https://en.wikipedia.org/wiki/SRGB>
* <https://en.wikipedia.org/wiki/Adobe_RGB_color_space>
* <https://en.wikipedia.org/wiki/CMYK_color_model>
* <https://en.wikipedia.org/wiki/CIE_1931_color_space#CIE_XYZ_color_space>
* <https://en.wikipedia.org/wiki/YIQ>
