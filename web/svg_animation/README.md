# SVG Animation

All about SVG for web design and animation.

## Notes

### Interactive Web Animation with SVG

Interactive web animation with SVG by Cassie Evans CSSCAMP 2019:

[![clip](https://img.youtube.com/vi/8p5SDI4TNDc/0.jpg)](https://www.youtube.com/watch?v=8p5SDI4TNDc)

My notes from the presentation:

* create initial artwork, or find existing e.g. with [freepik](https://www.freepik.com/)
* plan out animation with individual artboards/key frames
* collect all bits or animation into one SVG
* clean up the SVG code e.g. with [svgomg](https://jakearchibald.github.io/svgomg/)
* start working on animations - [codepen](https://codepen.io/) is a good place for this
* CSS transforms - simple place to start (some browser compatibility issues)
* animation libraries for more complex

| Library                               | Transforms | Timelines | Size   | License     |
|---------------------------------------|------------|-----------|--------|-------------|
| [anime.js](https://animejs.com/)      | √          | √         | 6kb    | MIT         |
| [greensock](https://greensock.com/)   | √          | √         | 9-36kb | Mostly Free |
| [velocity.js](http://velocityjs.org/) | √          | √         | 15kb   | MIT         |

#### A Little Test

Original artwork: [kraken.svg](https://www.freepik.com/free-icon/kraken_928781.htm#page=1&query=kraken&position=42) - made by [Freepik](https://www.flaticon.com/authors/freepik).

* [kraken.original.svg](./assets/kraken.original.svg) - original local copy
* [kraken.cleaned.svg](./assets/kraken.cleaned.svg) - cleaned up with [svgomg](https://jakearchibald.github.io/svgomg/)

##### Step 1: Simple CSS Animation

The kraken.svg only has two paths nicely separated - the eyes, and everything else.
So a simple animation task (without having to rip apart the SVG) would be to move the eyes.

The [kraken-css-anim.html](./kraken-css-anim.html) is an example of doing this with simple transform keyframes.
This is a snapshot of a simple [coden here](https://codepen.io/tardate/full/XWWVxzw).

Note: there are many ways of embedding the SVG from file, but it seem all the standard options do not allow the loaded SGV paths to then be manipulated with CSS.
Hence the example has the SVG image inlined.

[./kraken-css-anim.html](![kraken-css-anim](./assets/kraken-css-anim.png?raw=true))

## SVG Paths

See [SVG Paths spec](https://www.w3.org/TR/SVG/paths.html)

Example:

    <path d="M 100 100 L 300 100 L 200 300 z" fill="red" stroke="blue" stroke-width="3" />

All instructions are expressed as one character:

* `M` (absolute), `m` (relative) - moveto - Start a new sub-path at the given (`x,y`) coordinates
* `Z` or `z` - closepath - ends the current subpath by connecting it back to its initial point
* `L` (absolute), `l` (relative) - lineto - Draw a line from the current point to the given (`x,y`) coordinate
* `H` (absolute), `h` (relative) - lineto - Draw a horizontal line from the current point to the given (`x`) coordinate
* `V` (absolute), `v` (relative) - lineto - Draw a vertical line from the current point to the given (`y`) coordinate
* `C` (absolute) `c` (relative) - curveto - (x1 y1 x2 y2 x y)+ - cubic Bézier curve
* `S` (absolute) `s` (relative) - shorthand/smooth curveto - (x2 y2 x y)+ - cubic Bézier curve
* `Q` (absolute) `q` (relative) - quadratic Bézier curveto  (x1 y1 x y)+  Draws a quadratic Bézier curve
* `T` (absolute) `t` (relative) - Shorthand/smooth quadratic Bézier curveto (x y)+  Draws a quadratic Bézier curve
* `A` (absolute) `a` (relative) - elliptical arc  (rx ry x-axis-rotation large-arc-flag sweep-flag x y)+  Draws an elliptical arc

## Credits and References

* [Interactive web animation with SVG by Cassie Evans CSSCAMP 2019](https://youtu.be/8p5SDI4TNDc)
* [freepik](https://www.freepik.com/)
* [svgomg](https://jakearchibald.github.io/svgomg/)
* [codepen](https://codepen.io/)
* [anime.js](https://animejs.com/)
* [greensock](https://greensock.com/)
* [velocity.js](http://velocityjs.org/)
* [Using_CSS_animations](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Animations/Using_CSS_animations) - MDN
* [SVG element](https://developer.mozilla.org/en-US/docs/Web/SVG/Element/svg) - MDN
* [@keyframes](https://developer.mozilla.org/en-US/docs/Web/CSS/@keyframes) - MDN
* [The Best Way to Embed SVG on HTML (2019)](https://vecta.io/blog/best-way-to-embed-svg)
