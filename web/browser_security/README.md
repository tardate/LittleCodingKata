# Browser Security

Notes and summaries of key browser security and vulnerabilities.

## Notes

### Clickjacking

[Clickjacking attacks](https://javascript.info/clickjacking) lure a web user into interacting with a malicious code
while thinking they are using something different. The exploit can work in two directions:

* present a fake button/UI, but when the user clicks on it, they are in fact interacting with an underlying victim site
* present a real web page, overlaid with something fake that appears part of the real site (like a fake login popup)

The victim site is usually included in a web page with an
[IFRAME](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/iframe) or [OBJECT](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/object) tag.

Browsers (currently) do not prevent embedding by default. Victim sites must take active measures to prevent their site
being used in this way. Two primary mechanisms:

* set [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options) that instruct the browser to refuse to embed the site
* use Javascript to force a redirect to the "real" page if the page has been stuck in an iframe.

Sites that have historically been valuable targets of this type of attack have all the defences in pace (like facebook, twitter, google etc).

## Credits and References

* [clickjacking attack](https://javascript.info/clickjacking)
* [X-Frame-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options)
* [X-XSS-Protection](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-XSS-Protection)
* [X-Content-Type-Options](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options)
