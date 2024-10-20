# #016 RADIUS

Remote Authentication Dial-In User Service (RADIUS) is a networking protocol that provides centralized
Authentication, Authorization, and Accounting (AAA or Triple A) management for users who connect and use a network service.

## Summary

* originally developed by Livingston Enterprises
* provides centralized Authentication, Authorization, and Accounting (AAA)
* governed by the IETF (RFC 2865 and more)
* widely implemented and used
* can suffer degraded performance and lost data when used in large scale systems
* is an "old" protocol that lives on. The IETF's AAA working group may develop a successor protocol (possibly diameter?).

## Open Source Implementations

* [FreeRADIUS](http://freeradius.org/) [(wikipedia)](https://en.wikipedia.org/wiki/FreeRADIUS) - most popular server
* [pyrad](https://pypi.python.org/pypi/pyrad) - python
* [radius gems](https://www.ruby-toolbox.com/search?utf8=%E2%9C%93&q=radius) - ruby-toolbox
* [radius gems](https://rubygems.org/search?utf8=%E2%9C%93&query=radius) - rubygems

## Credits and References
* [RADIUS](https://en.wikipedia.org/wiki/RADIUS) - wikipedia
* [RFC 2865](https://tools.ietf.org/html/rfc2865) - IETF specification, obsoletes RFC 2138
* [RFC 6733 Diameter Base Protocol](https://tools.ietf.org/html/rfc6733)
* [RADIUS-Clients](http://wiki.freeradius.org/glossary/RADIUS-Clients) - freeradius
* [Authenticate Radius user with Ruby](http://stackoverflow.com/questions/32898184/authenticate-radius-user-with-ruby)

