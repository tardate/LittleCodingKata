# #007 Elm/hello_clock

Testing elm with the 2D graphics clock example.

[![hello_clock](./assets/hello_clock.png?raw=true)](https://codingkata.tardate.com/elm/hello_clock/index.html)

### The Example

This code is from the [elm examples: clock](http://elm-lang.org/examples/clock),
with some minor modifications to deface the clock with a text message.


## Notes

The clock example (only) runs in UTC.

There's been [discussion of timezone support](http://comments.gmane.org/gmane.comp.lang.elm.general/5872)
in elm, but at present it appears a bit weak.
There are some examples such as in the
[WebAPI.Date](https://github.com/rgrempel/elm-web-api/blob/master/src/WebAPI/Date.elm) module.
I need to explore a little more.

### Build

Use `elm make` to compile the source to HTML/javascript.

    elm make hello_clock.elm --output=index.html

This will generate `elm-package.json` and install dependencies in `elm-stuff` if not already done.

### Run

Open index.html in a browser. It is all self-contained: once built there is no runtime dependency on
the `elm-stuff` folder.

Or run the demo [live from GitHub Pages](https://codingkata.tardate.com/elm/hello_clock/index.html).

## Credits and References
* [elm examples/clock](http://elm-lang.org/examples/clock) - the original source
* [elm code package docs](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Basics)
