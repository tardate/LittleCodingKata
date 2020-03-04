# jQuery Date-Time Selectors

A Quick Survey of jQuery Date-Time Selector libraries and approaches (circa 2010)

## Notes

NB: this research was done in 2010 and needs updating. It was originally published on the [tardate blog](https://blog.tardate.com/2010/06/quick-survey-of-jquery-datetime-widgets.html).
For more recent info, see:

* [Best jQuery Date Picker Plugins for Input Fields](https://blog.teamtreehouse.com/best-jquery-date-picker-plugins-for-input-fields)
* [DATE PICKER - JQUERY PLUGIN](https://www.eyecon.ro/datepicker/)
* [CibulCalendar](https://github.com/kaore/CibulCalendar)
* [new version of Any+time](https://www.ama3.com/anytime/)

### Overview

Once again I find myself browsing around for a better javascript calendar tool. I'm particularly looking for jQuery support, the ability to handle both date and time entry, and — being post-iPhone/Android/iPad 2010 — I'm concerned about making sure it is finger friendly (i.e. it works on a touch screen).

The table below summarises my findings at this point. The ranking is just my personal view, and this list is certainly not all inclusive (if you know of other/better options I'd be really interested to hear from you). Each tool links to a test page where I've tried to cut everything back to the bare essentials needed to run a demo. Feel free to pinch the source if it helps.

Conclusions? There are some reasonably effective tools here for quickly dropping in date and time editing support, but at the end of the day I'm not sure that Google haven't already got it right with the simple combo-box time selectors in Google Calendar (is there a widget that includes something similar? Haven't found it yet).

### Evaluation

| Option | jQuery | jQuery UI |  Dates | Times | Finger Friendly | Comments | Rank |
|--------|--------|-----------|--------|-------|-----------------|----------|------|
| [jQuery Datepicker](./datePicker.html) | 1.4.2 | 1.8.2, 1.7.3 |  Yes | No  | Yes | The standard widget  | B |
| [Any+Time](./anytime.html) | 1.4.2 | n/a          |  Yes | Yes | Yes | Extensively customisable and scriptable. Supports jQuery UI themes. Also works with prototype instead of jQuery. Cannot edit the bound field while the widget is active. | A |
| [MartinMilesich's Timepicker](./MartinMilesich-timepicker.html) | 1.4.2 | 1.8.2, 1.7.2 |  Yes | Yes | Cannot use the time slider with finger, but you can select a point on the slider with finger OK. | Generally neat extension of the standard datepicker. Supports alternate fields to split out date/time component for easier processing.  | A- |
| [Trent Richardson's Timepicker](./timepicker.html) | 1.4.2 | 1.8.2        |  Yes | Yes | Cannot use the time slider with finger. You can select a point on the slider with finger, but there is a minor bug meaning you need to select twice. You can also edit the bound field while the widget is active. | Generally a very neat extension of the standard datepicker. Doesn't support all features however e.g. alternate fields  | B+ |
| [W3VISIONS Date-Time-Picker](http://blog.w3visions.com/2009/04/date-time-picker-with-jquery-ui-datepicker/) | 1.4.2 | n/a          |  Yes | Yes | Yes. Slider button doesn't work with the finger, but can select positions on the slider OK | The UI is a bit klunky and no themes support so I didn't bother with a demo page for this  | B- |
| [timepickr](./timepickr.html) | 1.4.2 | 1.7.3        |  No  | Yes | No fingers, no play (unless the device has a trackball you can fallback on)  | A different take on time entry. Maybe too different.  | C |

NB: version numbers refer to the latest versions that I have been able to successfully test

### Alternative Frameworks

jQuery is not the only game in town of course. Here are some others...

* [Calendar Date Select](http://code.google.com/p/calendardateselect/) Prototype-based Rails plugin
* Dojo [Date Controls](http://dojocampus.org/explorer/#Dijit_Form%20Controls_Text%20Boxes_Date) and [TimeSpinner](http://dojocampus.org/explorer/#Dojox_Widgets_TimeSpinner)
* MooTools [Datepicker](http://www.monkeyphysics.com/mootools/script/2/datepicker)
* YUI [Calendar](http://developer.yahoo.com/yui/calendar/), [timepicker](http://yuilibrary.com/gallery/show/timepicker)

## Credits and References

* [jQuery Home](https://jquery.com/)
* [Datejs](https://github.com/datejs/Datejs) extends javascript Date parsing capabilities and adds nice syntactic sugar
* [Date Format](http://blog.stevenlevithan.com/archives/date-time-format) extends javascript Date formating capabilities
