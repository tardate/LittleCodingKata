# Progress Bars with Bootstrap

[![demo_in_progress](./assets/demo_in_progress.png?raw=true)](http://tardate.github.io/LittleCodingKata/javascript/progress_bars_bootstrap/index.html)


[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

Bootstrap includes a [Progress Bar component](http://getbootstrap.com/components/#progress).

Styling follows bootstrap conventions of course, making it super-easy to drop a progress bar on a page:

* Contextual alternative styling: success, info, warning, danger
* Striped - gradient to create a striped effect
* Animated Striped - animates the gradient striped effect
* Stacked - place multiple bars into the same `.progress` container to stack them

The `.progress-bar` is contained within a `.progress` element:

```
<div class="progress" id="myProgressbar" >
  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
    0%
  </div>
</div>
```

Note that this does not use the HTML5 progress component.
It is possible to use the HTML5 element `<progress class="progress-bar ...></progress>`
however this breaks the bootstrap styling - it still works, but without the flair.


## Animating the Progress Bar

Styling alone simply displays a progress bar at a given % complete.

The [html5 spec](https://dev.w3.org/html5/spec-preview/the-progress-element.html) does not define
any direct animation support for the `<progress>` element.

Some Javascript is required to activate the progress bar for count-down or completion effects.

Strangely(?), there's no javascript support shipped in Bootstrap.
But adding it is very straight-forward. And how you add it depends very much on what you want the progress bar to indicate.


### Animation Options

Updating the progress bar simply requires setting the width:

    $('[role="progressbar"]').css('width', '75%')

For accessibility, it is good practice to also update the ARIA valuenow:

    $('[role="progressbar"]').attr('aria-valuenow', 75);

And to display the percent complete (or other info) in the bar as it changes, update the text:

    $('[role="progressbar"]').text(current_percent+ '%');

NB: if there is no text on the bar, it may be appropriate to include a screen-reader element instead:

    $('[role="progressbar"]').html('<span class="sr-only">75% Complete</span>')

Bootstrap includes a default css transition (0.6 seconds) that will animate the change.

But if updates are emitted too fast, the bar will increasingly lag the desired value.
It will catch up eventually, but can make for some unexpected animation sequences.

For progress updates that are not measuring time (e.g. sales, health, ammo), then a good css transition setting
and Javascript that updates the progress bar position as required is probably the best approach.


#### Using setTimeout

If the intention is to use the progress bar to measure the passage of time,
the obvious answer is a conventional `setTimeout` recursive function.

Most examples found on the net use this technique.

There's a [bootstrap-progressbar](https://github.com/minddust/bootstrap-progressbar) library available
that adds progressbar interactions for twitter bootstrap 2 & 3.  It uses the setTimeout technique.

Depending on the speed of progress, it is probably desirable to override the
default bootstrap transition on `.progress-bar`.

The example in [index.html](./index.html) includes a `setTimeout` example.

* it implements a 0-100% timer over a pre-determined time (5 seconds).
* it uses a standard recursive `setTimeout` pattern is used to update the progress bar value accordingly.
* it sets a shorter css transition time to create a more appropriate yet smooth animation.


#### Using jQuery.animate

If the intention is to use the progress bar to measure the passage of time,
another option is [jQuery.animate](http://api.jquery.com/animate/).

This simplifies the animation task, as there's no need to ensure the css transition matches the rate of animation.

For time-based effects, I think I prefer this technique.


## The Demo

The example in [index.html](./index.html) is an adaptation of a [dynamic progress bar example](http://codepen.io/jbeurel/pen/zuDAl) by
[@jbeurel](https://twitter.com/jbeurel). It is extended to demonstrate:

* animation with setTimeout
* animation with jQuery.animate
* fiddling css transition to allow immiedate updates yet smooth setTimeout animation

Run the demo [live from GitHub Pages](http://tardate.github.io/LittleCodingKata/javascript/progress_bars_bootstrap/index.html)

In the HTML, action are hooked to a button:

* where `data-duration` is the time in seconds to animate over
* and `data-method` selects the animation technique

```
<button class="btn btn-primary" data-toggle="progressbar" data-target="#myProgressbar" data-duration="5" data-method="animateWithJquery">
  Start a 5 second timer (jQuery.animate)
</button>
```

It can also be exercised in Javascript:

```
$('#myProgressbar').progressbar("reset") // reset to 0%
$('#myProgressbar').progressbar("update", 65) // set 65%
$('#myProgressbar').progressbar("animateWithJquery", 15) // 15 second 0-100% animation with jQuery.animate
$('#myProgressbar').progressbar("animateWithTimeouts", 10) // 10 second 0-100% animation with setTimeout
```

## Credits and References
* [Progress bars](http://getbootstrap.com/components/#progress) - bootstrap doc
* [dynamic progress bar example](http://codepen.io/jbeurel/pen/zuDAl) - where I borrowed code for this test
* [Cross Browser HTML5 Progress Bars In Depth](http://www.useragentman.com/blog/2012/01/03/cross-browser-html5-progress-bars-in-depth/)
* [SO: How to increment a bootstrap progress bar?](http://stackoverflow.com/questions/12218670/how-to-increment-a-bootstrap-progress-bar?rq=1)
* [SO: Change Bootstrap progress bar dynamically](http://stackoverflow.com/questions/26432408/change-bootstrap-progress-bar-dynamically)
* [SO: Dynamically change bootstrap progress bar value when checkboxes checked](http://stackoverflow.com/questions/21182058/dynamically-change-bootstrap-progress-bar-value-when-checkboxes-checked)
* [WAI-ARIA Supported States and Properties](https://www.w3.org/TR/wai-aria/states_and_properties)
* [bootstrap-progressbar](https://github.com/minddust/bootstrap-progressbar) - adds the missing javascript
* [jquery animate doc](http://api.jquery.com/animate/)
