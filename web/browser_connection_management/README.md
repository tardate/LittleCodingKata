# Browser Connection Management

Notes on how web browsers manage network connections

## Notes

Just some links and references...

### General References

Good docs on browser connection management

* <https://en.wikipedia.org/wiki/HTTP_persistent_connection>
* <https://developer.mozilla.org/en-US/docs/Web/HTTP/Connection_management_in_HTTP_1.x>
* <https://www.igvita.com/posa/high-performance-networking-in-google-chrome/>

### Detecting network changes

* <https://developer.mozilla.org/en-US/docs/Web/API/NetworkInformation>
* <https://googlechrome.github.io/samples/network-information/>

example, fires on wifi change. wonder if it fires when wan changes?

    navigator.connection.onchange = function(e) { console.log("net change", e) }
    => net change Event { ...}

advanced connection status tracking:

* <https://medium.com/@JackPu/how-javascript-detect-the-network-status-42f3a6d85f96>
* <https://github.com/JackPu/network-heart-service/blob/master/src/index.js>
* <https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API>
