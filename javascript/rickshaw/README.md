# Rickshaw

Testing out the D3-based Rickshaw time series graph library

## Notes

[Rickshaw](https://tech.shutterstock.com/rickshaw/) is:

* a JavaScript toolkit for creating interactive time series graphs
* built on d3.js
* open source (MIT license)
* developed at Shutterstock
* available on [CDN (cdnjs)](https://cdnjs.com/libraries/rickshaw)

See also:

* [online examples](https://tech.shutterstock.com/rickshaw/examples/)
* [tutorial](https://tech.shutterstock.com/rickshaw/tutorial/introduction.html)


### Installation Options

* download compiled sources from [github](https://github.com/shutterstock/rickshaw)
* install with bower `bower install rickshaw`
* install with npm `npm install --save rickshaw`
* direct from [CDN (cdnjs)](https://cdnjs.com/libraries/rickshaw)


### Using a CDN

Requires:

* [rickshaw](https://cdnjs.com/libraries/rickshaw) css and js
* [d3](https://cdnjs.com/libraries/d3/3.5.16) - but latest versions don't work
* optionally jquery ~>1.8.1

e.g.

```
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/rickshaw/1.6.6/rickshaw.css" integrity="sha256-3vAiod7sePtPgQYpPMFvmDNLWVbCeYiEjb9p4lt3PXQ=" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/d3/3.5.16/d3.min.js" integrity="sha256-uB5nPcWK8vr5e83snqtMUYJ2n/5TZ3PV9CCRk1pzob4=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/rickshaw/1.6.6/rickshaw.js" integrity="sha256-F4WIKaQsZ/uUDfd1G2srG7DoLrveN3Q4LoaQ+4RI/PQ=" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>
```


### Quick Demo

See [demo.html](./demo.html) for a quick test of:

* applying color palettes
* loading data with AJAX

[![demo](./assets/demo.png?raw=true)](./demo.html)

## Credits and References

* [Rickshaw](https://tech.shutterstock.com/rickshaw/) - home
* [Rickshaw](https://cdnjs.com/libraries/rickshaw) - cdnjs
* [Rickshaw](https://github.com/shutterstock/rickshaw) - github
