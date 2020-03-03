# Database Tweets

Tweeting from your Oracle database with short urls

## Notes

> NB: I originally posted this [back in 2009](https://blog.tardate.com/2009/04/tweeting-from-your-database-with-short.html)

There's something cheekily enjoyable about getting all manner of 'non-human' things to tweet.
I've heard of [plants tweeting](https://www.botanicalls.com/kits/),
but until I saw Lewis Cunningham's post announcing
[ORA_Tweet](https://web.archive.org/web/20110315080933/http://database-geek.com/2009/03/15/ora_tweet-tweet-from-oracle-a-plsql-twitter-api/), I hadn't even thought of getting Oracle Database onto twitter.
Since twitter famously limits you to 140 characters, it is conventional to use a url-shortening service to include hyperlinks in your tweet. So my little modification was to pair that idea up with ORA_Tweet.

There are a range of URL shortening services available. I've been using is.gd for a while though, since it sports the simplest GET request 'api' you could imagine, making it great for ad-hoc programmatic use.

So I add an extra package called SHORT_URL which has just two functions:

```
FUNCTION encode_url(
  p_url IN VARCHAR2 )
RETURN VARCHAR2;

FUNCTION encode_text(
  p_text IN VARCHAR2 )
RETURN VARCHAR2;
```

`encode_url` is the main wrapper around the http://is.gd call to get a short url for the one you provide.

`encode_text` is a more convenient function that takes a block of text, and will replace all the urls it contains with the appropriate shortened versions.

Then there's just one change to the ORA_TWEET package body:

```
45c45
<       url => 'status=' || SUBSTR( short_url.encode_text(p_string) ,1,140));
---
>       url => 'status=' || SUBSTR(p_string,1,140));
```

Now you can go wild with URLs in your database tweets:

```
BEGIN
  DBMS_OUTPUT.ENABLE;
  IF ora_tweet.tweet
    (
      p_user => 'twitter_username',
      p_pwd => 'twitter_password',
      p_string => 'ora_tweet v1.1 is complete! Now with url shortening ... see http://database-geek.com/2009/03/15/ora_tweet-tweet-from-oracle-a-plsql-twitter-api/' )
  THEN
    dbms_output.put_line('Success!');
  ELSE
    dbms_output.put_line('Failure!');
  END IF;
END;
```

### Sources:

* [call_twitter_pkg.sql](./call_twitter_pkg.sql) - example of making a tweet
* [shorturl.pkg](./shorturl.pkg) - loads the short_url package
* [twitter.pks](./twitter.pks) - ora_tweet package spec
* [twitter_2.pkb](./twitter_2.pkb) - ora_tweet package body

## Credits and References

* [original blog post](https://blog.tardate.com/2009/04/tweeting-from-your-database-with-short.html)
* [Ora_Tweet – Tweet From Oracle, A PL/SQL Twitter API](https://web.archive.org/web/20110315080933/http://database-geek.com/2009/03/15/ora_tweet-tweet-from-oracle-a-plsql-twitter-api/) - archive.org
