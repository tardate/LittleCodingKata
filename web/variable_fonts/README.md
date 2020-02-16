# Variable Fonts

Understanding the new standards for variable CSS fonts.

## Notes

A variable font is a single font file that can be used to render a range of propertyies e.g. size, weight, style.
Support for variable fonts is being codified in the W3C Working Draft [CSS Fonts Module Level 4](https://www.w3.org/TR/css-fonts-4/).
Most leading browsers already support variable fonts to some degree.

The OpenType 1.8 specification defines five registered axis tags:

* weight <wght>
* width <wdth>
* optical size <opsz>
* slant <slnt>
* italic <ital>

It seems some fonts provide additional axis for more fun and creative control - a popular
example is [decovar](https://github.com/TypeNetwork/Decovar) which really has an insane number of axis to play with.

While some properties can be adusted with familiar font properties (`font-weight` etc),
the [font-variation-settings](https://developer.mozilla.org/en-US/docs/Web/CSS/font-variation-settings)
property is used to control all the axis supported by a particular font.

### Demo - Source Sans Pro

[demo/index.html](./demo/index.html) is a simple demonstration of using mouse movement
to affect continuous variation of form attributes (size and weight in the case).

The font used is [source-sans-pro 3.006 (OTF, TTF, WOFF, WOFF2, Variable)](https://github.com/adobe-fonts/source-sans-pro/releases/tag/3.006R).

Getting the latest variable fonts and installing for the demo:

```
wget https://github.com/adobe-fonts/source-sans-pro/releases/download/3.006R/source-sans-pro-3.006R.zip
unzip source-sans-pro-3.006R.zip
rm source-sans-pro-3.006R.zip
cp source-sans-pro-3.006R/WOFF2/VAR/SourceSansVariable-Roman.ttf.woff2 demo
cp source-sans-pro-3.006R/WOFF/VAR/SourceSansVariable-Roman.ttf.woff demo
cp source-sans-pro-3.006R/VAR/SourceSansVariable-Roman.ttf demo
```

A picture doesnt really convey the intent. Try it interactively:

[![demo](./assets/demo.png?raw=true)](./demo/index.html)

## Credits and References

* [CSS Fonts Module Level 4](https://www.w3.org/TR/css-fonts-4/) - W3C Working Draft
* [font-variation-settings](https://developer.mozilla.org/en-US/docs/Web/CSS/font-variation-settings)
* [HTML DOM MouseEvent](https://www.w3schools.com/jsref/obj_mouseevent.asp)
* [The Window Object](https://www.w3schools.com/jsref/obj_window.asp)
* [How to Use Variable Fonts on the Web](https://webdesign.tutsplus.com/articles/how-to-use-variable-fonts-on-the-web--cms-30212)
* [How to use variable fonts in the real world](http://clagnut.com/blog/2390/) - clagnut
* [v-fonts](https://v-fonts.com/) A simple resource for finding and trying variable fonts
* [source-sans-pro](https://github.com/adobe-fonts/source-sans-pro) - github
