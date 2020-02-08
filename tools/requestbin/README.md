# Request Bin

Using request bin services to inspect HTTP events - Runscope self-hosted and newer Pipedream services with with workflows aka programmable bins.

## Notes

I was a long-time user of the old [Runscope](https://www.runscope.com/) requestb.in service for capturing real payloads from live services.
It was a shame when they had to shutter the public service due to abuse, but the silver lining
was how they open-sourced a version of [requestbin](https://github.com/Runscope/requestbin) that we could run for ourselves.

[Runscope](https://www.runscope.com/) have since focused on their core API monitoring service.

Now I'm updating my notes on running a request bin, I stumbled upon the fact that
there's a new(?) player in town - [Pipedream](https://docs.pipedream.com/).
As far as I can tell they only have the free offering for now but may be introducing paid tiers in future.

I took pipedream for a test drive and was really impressed - in addition to being slickly integrated,
the workflow features make it the [IFTTT](https://ifttt.com/) of request bining.

### Self-hosting requestbin

See the [requestbin](https://github.com/Runscope/requestbin#readme) repo for instructions.
It is trivial to deploy a personal instance to heroku:

```
$ git clone git://github.com/Runscope/requestbin.git
$ cd requestbin
$ heroku create
$ heroku addons:add heroku-redis
$ heroku config:set REALM=prod
$ git push heroku master
```

The application runs with the classic Runscope interface...

[![self_hosted_requestbin](./assets/self_hosted_requestbin.png?raw=true)](https://github.com/Runscope/requestbin#readme)

### Using Pipedream

Pipedream appears to have publically launched in Oct 2019. They are currently running two services that are semi-integrated:

* [requestbin.com](https://requestbin.com/) offers traditional public request bins; perhaps this is an early rev that will eventually be retired
* [pipedream.com](https://pipedream.com/) which has all the new goodness - including private bins, logging and workflows

#### Simple Request Bins

The [requestbin.com](https://requestbin.com/) domain offers the choice of public or private request bins, or this new thing called a "programmable bin"..

[![requestbin](./assets/requestbin.png?raw=true)](https://requestbin.com/)

Choosing a public request bin behaves very much like good old requestb.in, but with a snazzier UI:

![public_bin](./assets/public_bin.png?raw=true)

#### Programmable Bins

The funs starts when you choose a "programmable bin", or go direct to [pipedream.com](https://pipedream.com/):

[[![pipedream](./assets/pipedream.png?raw=true)](https://pipedream.com/)](https://pipedream.com/)

A "programmable bin" basically means that instead of just logging the incoming payload,
it is possible to define a workload that can:

* inspect and log details of the request
* transform or process the request
* log data for later analysis or use
* trigger external services
* send notifications e.g. via email, SMS
* trigger a "smart reply"

A good first step is to [explore featured workflows](https://pipedream.com/explore) and play with them,
with occassional reference to the [docs](https://docs.pipedream.com/) of course.

#### Programmable Bin Example

I copied some ideas from featured workflows and put together a neat little service that doesn't even need an incoming trigger request.

The ["Mail me new items from the LEAP feed"](https://pipedream.com/@tardate/mail-me-new-items-from-the-leap-feed-p_yKCPnz/edit) is

* triggered on a schedule (cron)
* pulls the [RSS (Atom) feed](https://leap.tardate.com/catalog/atom.xml) from my [LEAP (Little Electronics and Arduino Projects) repo](https://leap.tardate.com)
* summarises any new posts (by comparing with checkpoint that persists across executions)
* generates and sends me an email with the new posts

All pretty cool for something that started life as an web request monitor!

The workflow editor is pretty slick, and I believe powered by the [Monaco editor](https://microsoft.github.io/monaco-editor/).

Here's my workflow in the editor (anyone can copy the workflow and make their own changes):

![leap_wf](./assets/leap_wf.png?raw=true)

It generates a simple text mail that is delivered through pipedream's servers FOC!

![leap_wf_mail](./assets/leap_wf_mail.png?raw=true)

## Credits and References

* [Pipedream](https://pipedream.com/) aka [requestbin.com](https://requestbin.com/)
* [requestbin](https://github.com/Runscope/requestbin) - the open source request bin self-hosted service
* [Runscope](https://www.runscope.com/)
