# #400 About dweet.cc

Dweet.cc provides simple machine-to-machine messaging over HTTPS.
No setup. No auth. Just post and get lightweight JSON.

## Notes

I've recently been looking for modern substitutes for all the
data platforms that sprouted during the initial IoT craze in the mid 2010's.
Most no longer exist!

Perhaps the simplest and most straight-forward I've found so far is [dweet.cc](https://dweet.cc/).

It provides simple machine-to-machine messaging over HTTP.
No setup. No auth. Just post and get lightweight JSON.

How simple? This simple:

* GET to post new data
* GET the latest message
* GET all the messages

```sh
$ curl "https://dweet.cc/dweet/for/my-thing-name?temperature=23.2&unit=C"
{
    "this": "succeeded",
    "by": "dweeting",
    "the": "dweet",
    "with": {
        "thing": "my-thing-name",
        "created": "2026-01-04T13:57:59+00:00",
        "content": {
            "temperature": "23.2",
            "unit": "C"
        }
    }
}
$ curl https://dweet.cc/get/latest/dweet/for/my-thing-namee
{
    "this": "succeeded",
    "with": [
        {
            "thing": "my-thing-name",
            "created": "2026-01-04 13:57:59",
            "content": {
                "temperature": "23.2",
                "unit": "C"
            }
        }
    ]
}
$ curl https://dweet.cc/get/dweets/for/my-thing-name
{
    "this": "succeeded",
    "with": [
        {
            "thing": "my-thing-name",
            "created": "2026-01-04 13:57:59",
            "content": {
                "temperature": "23.2",
                "unit": "C"
            }
        },
        {
            "thing": "my-thing-name",
            "created": "2026-01-04 00:34:52",
            "content": {
                "temperature": "26",
                "unit": "C"
            }
        },
        {
            "thing": "my-thing-name",
            "created": "2026-01-04 00:34:10",
            "content": {
                "temperature": "26",
                "unit": "c"
            }
        }
    ]
}
```

By default, all this data is freely available to anyone if they know your "thing-name".

It's possible to keep things a little more private

```sh
$ curl "https://dweet.cc/dweet/for/my-private-thing-name?temp=23&private=1"
{
    "this": "succeeded",
    "by": "dweeting",
    "the": "dweet",
    "with": {
        "thing": "my-private-thing-name",
        "created": "2026-01-06T06:22:50+00:00",
        "content": {
            "temp": "23",
            "private": "1"
        },
        "auth_token": "9eb97d33cd08f1eb9c8cf8601cedd645"
    }
}
$ curl "https://dweet.cc/get/latest/dweet/for/my-private-thing-name?auth=9eb97d33cd08f1eb9c8cf8601cedd645"
{
    "this": "succeeded",
    "with": [
        {
            "thing": "my-private-thing-name",
            "created": "2026-01-06 06:22:50",
            "content": {
                "temp": "23",
                "private": "1"
            }
        }
    ]
}
```

If I don't provide the auth token:

```sh
$ curl "https://dweet.cc/get/latest/dweet/for/my-private-thing-name"
{
    "this": "failed",
    "because": "Authentication required"
}
$ curl "https://dweet.cc/get/latest/dweet/for/does-not-exist-1234123412341234"
{
    "this": "failed",
    "because": "No dweets found"
}
```

So, my private dweets were protected by the token, but the response did leak the fact that my dweets exist.

## Issues/Limitations

* It only supports HTTPS - so if you are looking for an HTTP-only solution for constrained devices, this is not it
* The service only holds on to the last 5 dweets over a 24 hour period. If the thing hasn't dweeted in the last 24 hours, its history will be removed.
* ALL DWEETS ARE PUBLIC unless specifically made private. Anonymous clients won't see private dweets.
* Don't name the dweet anything that expresses anything confidential, as the API will confirm its existence even if private

## Credits and References

* [dweet.cc](https://dweet.cc/)
