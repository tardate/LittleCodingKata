# Color Pickers for the Web

Looking at easy ways to enable a color picker on a web page

## Notes

How to let a user pick a color on a web page?

That ued to be a non-trivial coding problem, but then there cam some good Javascript libraries such
as [jscolor](https://jscolor.com/). These are still the best bet for maximal cross-browser compatibility.

These days however, the preferred option would be to use the HTML5
[`<input type="color">`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/color)
element.

### HTML5 Example

Open the [example.html](./example.html) for a quick demonstration of the HTML5 color picker component:

[![example.png](./assets/example.png?raw=true)](./example.html)

### jscolor Example

See [jscolor-examples.html](./jscolor-2.4.5/jscolor-examples.html) - this is straight from the [jscolor](https://jscolor.com/) distribution:

[![jscolor-example.png](./assets/jscolor-example.png?raw=true)](./jscolor-2.4.5/jscolor-examples.html)

## Credits and References

* [`<input type="color">`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/color) - MDN Web Docs
* [HTML Living Standard](https://html.spec.whatwg.org/multipage/input.html#color-state-(type%3Dcolor))
* [JavaScript color picker with opacity channel](https://jscolor.com/)
* [HTML Color Picker](https://www.w3schools.com/colors/colors_picker.asp?colorhex=F0FFFF) - documentation and examples
