# Progress Bars with Bootstrap

[![demo_in_progress](./assets/demo_in_progress.png?raw=true)](http://tardate.github.io/LittleCodingKata/javascript/progress_bars_bootstrap/index.html)

## Notes

Bootstrap includes a [Progress Bar component](http://getbootstrap.com/components/#progress).

It supports a range of styling over the underlying HTML5 progress component.
Styling follows bootstrap conventions of course, making it super-easy to drop a progress bar on a page:

* Contextual alternative styling: success, info, warning, danger
* Striped - gradient to create a striped effect
* Animated Striped - animates the gradient striped effect
* Stacked - place multiple bars into the same `.progress` container to stack them

Styling alone simply displays a progress bar at a given % complete.

Some Javascript is required to activate the progress bar for count-down or completion effects.

Strangely however, there's no javascript support shipped in Bootstrap.
But adding it is very straight-forward. And how you add it depends very much on what you want the progress bar to indicate.

The example in [index.html](./index.html) is an adaptation of a [dynamic progress bar example](http://codepen.io/jbeurel/pen/zuDAl) by
[@jbeurel](https://twitter.com/jbeurel).

Run the demo [live from GitHub Pages](http://tardate.github.io/LittleCodingKata/javascript/progress_bars_bootstrap/index.html)

### Animating the Progress Bar

The [html5 spec](https://dev.w3.org/html5/spec-preview/the-progress-element.html) does not define
any direct animation support.

Some browsers (recent Chrome, Firefox) implement default animation. i.e. when you update
the progress bar current value from 0 to 100, the change from 0 to 100 is animated over about a second.

So if you want the change to take about a second - nothing to do, just let the browser take over.

I have yet to find any documentation about or means to control the built-in animation duration,
so to animate the bar over other durations, or to display progress in units other than time,
it's necessary to resort to some simple Javascript.

The example in [index.html](./index.html) implements a 0-100% timer over a pre-determined time (5 seconds).
A standard recursive `setTimeout` pattern is used to update the progress bar value accordingly.

In the HTML, this action is hooked to a button (where `data-duration` is the time in seconds to animate over):

```
<button class="btn btn-default btn-primary" data-toggle="progressbar" data-target="#myProgressbar" data-duration="5">
  Start
</button>
```

But it can also be exercised in Javascript. This will reset the bar, then animate to 100% over 15 seconds:
```
$('#myProgressbar').progressbar("reset")
$('#myProgressbar').progressbar("run", 15)
```

### Built-in Animation Trap

I have yet to find any documentation on how to control the built-in animation duration,
so there's a trap here: since the browser has a built-in animation for the progress bar,
there's a limit to how fast one can change the bar positioning.

For example, this will produce a smooth animation of the bar going to 100%, back to 0% and again to 100%:

```
$('#myProgressbar').progressbar("update", 100)
$('#myProgressbar').progressbar("update", 0)
$('#myProgressbar').progressbar("update", 100)
```

If updates are emitted too fast, the bar will increasingly lag the desired value.
It will catch up eventually, but can make for some unexpected animation sequences.

## Credits and References
* [Progress bars](http://getbootstrap.com/components/#progress) - bootstrap doc
* [dynamic progress bar example](http://codepen.io/jbeurel/pen/zuDAl) - where I borrowed code for this test
* [Cross Browser HTML5 Progress Bars In Depth](http://www.useragentman.com/blog/2012/01/03/cross-browser-html5-progress-bars-in-depth/)
* [SO: Change Bootstrap progress bar dynamically](http://stackoverflow.com/questions/26432408/change-bootstrap-progress-bar-dynamically)
* [SO: Dynamically change bootstrap progress bar value when checkboxes checked](http://stackoverflow.com/questions/21182058/dynamically-change-bootstrap-progress-bar-value-when-checkboxes-checked)
* [WAI-ARIA Supported States and Properties](https://www.w3.org/TR/wai-aria/states_and_properties)
