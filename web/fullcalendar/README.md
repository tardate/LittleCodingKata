# #224 fullcalendar

Using the fullcalendar library for the web.

## Notes

### About fullcalendar

Built for JavaScript:
FullCalendar's vanilla JavaScript API is blazing fast, using a very small embedded virtual DOM library called Preact.

Built for Angular:
FullCalendar provides a high-performance Angular component that intelligently rerenders when data is mutated.

Built for Vue:
FullCalendar provides a high-performance Vue component that intelligently rerenders when data is mutated.

Built for React:
FullCalendar generates real React virtual DOM nodes so you can leverage Fiber, React's highly optimized rendering engine.

### v5.11.0

Currently, the latest version is
[v5.11.0](https://github.com/fullcalendar/fullcalendar/releases/tag/v5.11.0)

Notable in this version:

* calendar is initialised and a new class given a DOM node. Does not required jQuery: `calendar = new FullCalendar.Calendar(calendarEl, {});`
* [events (as a function)](https://fullcalendar.io/docs/events-function) takes 3 args: fetchInfo, successCallback, failureCallback
* [eventClick](https://fullcalendar.io/docs/eventClick) takes 1 arg: eventClickInfo

#### v5.11.0 Examples

```bash
mkdir fullcalendar-5.11.0
cd fullcalendar-5.11.0
wget https://github.com/fullcalendar/fullcalendar/releases/download/v5.11.0/fullcalendar-5.11.0.zip
unzip fullcalendar-5.11.0.zip
rm fullcalendar-5.11.0.zip
```

Running the standard demo:

```bash
open fullcalendar-5.11.0/examples/theming.html
```

Bootstrap 4:

![demo-bs4](./assets/v5110/demo-bs4.png?raw=true)

Bootstrap 5:

![demo-bs5](./assets/v5110/demo-bs5.png?raw=true)

### v3.9.0

[v3.9.0 (2018-03-04)](https://github.com/fullcalendar/fullcalendar/releases/tag/v3.9.0)

Notable in this version:

* calendar is initialised directly on a jQuery DOM node: `$('#calendar').fullCalendar({});`
* [events (as a function)](https://fullcalendar.io/docs/v3/events-function) takes 4 args: start, end, timezone, callback
* [eventClick](https://fullcalendar.io/docs/v3/eventClick) takes 3 args: event, jsEvent, view
* [header](https://fullcalendar.io/docs/v3/header) defines options for left, center, right

#### v3.9.0 Examples

```bash
wget https://github.com/fullcalendar/fullcalendar/releases/download/v3.9.0/fullcalendar-3.9.0.zip
unzip fullcalendar-3.9.0.zip
rm fullcalendar-3.9.0.zip
```

Running the standard theme demo:

```bash
open fullcalendar-3.9.0/demos/themes.html
```

v3.9.0 added Bootstrap 4 theme support.

![demo-bs4](./assets/v390/demo-bs4.png?raw=true)

### v1.5.4

[v1.5.4 (10 Sep 2013)](https://github.com/fullcalendar/fullcalendar/releases/tag/v1.5.4)

Notable in this version:

* calendar is initialised directly on a jQuery DOM node: `$('#calendar').fullCalendar({});`
* [events (as a function)](https://fullcalendar.io/docs/v3/events-function) takes 2 args: start, end, callback
* [eventClick](https://fullcalendar.io/docs/v1/eventClick) takes 3 args: event, jsEvent, view
* [header](https://fullcalendar.io/docs/v1/header) defines options for left, center, right

#### v1.5.4 Examples

```bash
mkdir fullcalendar-1.5.4
cd fullcalendar-1.5.4
wget https://github.com/fullcalendar/fullcalendar/releases/download/v1.5.4/fullcalendar-1.5.4.zip
unzip fullcalendar-1.5.4.zip
rm fullcalendar-1.5.4.zip
```

Running the standard theme demo:

```bash
open fullcalendar-1.5.4/demos/theme.html
```

![demo-theme](./assets/v154/demo-theme.png?raw=true)

## Credits and References

* [fullcalendar](https://fullcalendar.io/) - main site
* [fullcalendar](https://github.com/fullcalendar/fullcalendar) - github
