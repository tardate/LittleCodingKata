# RSS and Atom

About RSS and Atom feeds for publishing and podcasting.

## Notes

RSS 2.0 is the most common(?) feed format used in the wild, but it is a frozen standard owned by Harvard University.
The standards-based Atom format is more extensible but has not had as wide adoption.

## RSS

There are multiple versions of [RSS](https://en.wikipedia.org/wiki/RSS). Two main branches:

* RDF (or RSS 1.x) - the "RDF Site Summary"
* RSS 2.x. By 2.0.1, officially "Really Simple Syndication"

Example RSS 2.0 feed:

```
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
  <channel>
    <title>Example Feed</title>
    <description>Insert witty or insightful remark here</description>
    <link>http://example.org/</link>
    <lastBuildDate>Sat, 13 Dec 2003 18:30:02 GMT</lastBuildDate>
    <managingEditor>johndoe@example.com (John Doe)</managingEditor>
    <item>
      <title>Atom-Powered Robots Run Amok</title>
      <link>http://example.org/2003/12/13/atom03</link>
      <guid isPermaLink="false">urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a</guid>
      <pubDate>Sat, 13 Dec 2003 18:30:02 GMT</pubDate>
      <description>Some text.</description>
    </item>
  </channel>
</rss>
```

The conventional internet media type is `application/rss+xml`

## Atom

The [Atom Syndication Format](https://en.wikipedia.org/wiki/Atom_(Web_standard)) is an XML language used for web feeds.
It emerged as a format intended to rival or replace RSS,
and has been standardised in [rfc4287 The Atom Syndication Format](https://tools.ietf.org/html/rfc4287)
and [rfc5023 The Atom Publishing Protocol](https://tools.ietf.org/html/rfc5023).

General rules:

* All Atom feeds must be well-formed XML documents, and are identified with the `application/atom+xml` media type.
* All elements described in this document must be in the `http://www.w3.org/2005/Atom` namespace.
* All timestamps in Atom must conform to RFC 3339.
* Unless otherwise specified, all values must be plain text (i.e., no entity-encoded html).
* `xml:lang` may be used to identify the language of any human readable text.
* `xml:base` may be used to control how relative URIs are resolved.

An example of a document in the Atom Syndication Format:

```
<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <title>Example Feed</title>
  <subtitle>A subtitle.</subtitle>
  <link href="http://example.org/feed/" rel="self" />
  <link href="http://example.org/" />
  <id>urn:uuid:60a76c80-d399-11d9-b91C-0003939e0af6</id>
  <updated>2003-12-13T18:30:02Z</updated>
  <entry>
    <title>Atom-Powered Robots Run Amok</title>
    <link href="http://example.org/2003/12/13/atom03" />
    <link rel="alternate" type="text/html" href="http://example.org/2003/12/13/atom03.html"/>
    <link rel="edit" href="http://example.org/2003/12/13/atom03/edit"/>
    <id>urn:uuid:1225c695-cfb8-4ebb-aaaa-80da344efa6a</id>
    <updated>2003-12-13T18:30:02Z</updated>
    <summary>Some text.</summary>
    <content type="xhtml">
      <div xmlns="http://www.w3.org/1999/xhtml">
        <p>This is the entry content.</p>
      </div>
    </content>
    <author>
      <name>John Doe</name>
      <email>johndoe@example.com</email>
    </author>
  </entry>
</feed>
```

The following tag should be placed into the head of an HTML document to provide a link to an Atom feed.

```
<link href="atom.xml" type="application/atom+xml" rel="alternate" title="Sitewide Atom feed" />
```

## Podcasting Feeds

RSS 2.0 support for [enclosures](https://en.wikipedia.org/wiki/RSS_enclosure) led directly to the development of podcasting.

```
<enclosure url="http://example.com/file.mp3" length="123456789" type="audio/mpeg" />
```

Enclosures with Atom: `rel="enclosure"` on `<link>`

```
<link rel="enclosure" href="http://example.com/file.mp3" />
```

To appear in the iTunes Store, add the following namespace declaration

```
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" version="2.0">
```

See [Spec: iTunes Podcast RSS](https://github.com/simplepie/simplepie-ng/wiki/Spec:-iTunes-Podcast-RSS)

Example iTunes-compatible podcast feed:

```
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd">
    <channel>
        <title>All About Everything</title>
        <link>http://www.example.com/podcasts/everything/index.html</link>
        <language>en-us</language>
        <copyright>℗ &amp; © 2014 John Doe &amp; Family</copyright>
        <itunes:subtitle>A show about everything</itunes:subtitle>
        <itunes:author>John Doe</itunes:author>
        <itunes:summary>All About Everything is a show about everything. Each week we dive into any subject known to man and talk about it as much as we can. Look for our podcast in the Podcasts app or in the iTunes Store</itunes:summary>
        <description>All About Everything is a show about everything. Each week we dive into any subject known to man and talk about it as much as we can. Look for our podcast in the Podcasts app or in the iTunes Store</description>
        <itunes:owner>
            <itunes:name>John Doe</itunes:name>
            <itunes:email>john.doe@example.com</itunes:email>
        </itunes:owner>
        <itunes:image href="http://example.com/podcasts/everything/AllAboutEverything.jpg"/>
        <itunes:category text="Technology">
            <itunes:category text="Gadgets"/>
        </itunes:category>
        <itunes:category text="TV &amp; Film"/>
        <itunes:category text="Arts">
            <itunes:category text="Food"/>
        </itunes:category>
        <itunes:explicit>no</itunes:explicit>
        <item>
            <title>Shake Shake Shake Your Spices</title>
            <itunes:author>John Doe</itunes:author>
            <itunes:subtitle>A short primer on table spices</itunes:subtitle>
            <itunes:summary><![CDATA[This week we talk about
                <a href="https://itunes/apple.com/us/book/antique-trader-salt-pepper/id429691295?mt=11">salt and pepper shakers</a>
                , comparing and contrasting pour rates, construction materials, and overall aesthetics. Come and join the party!]]></itunes:summary>
            <itunes:image href="http://example.com/podcasts/everything/AllAboutEverything/Episode1.jpg"/>
            <enclosure length="8727310" type="audio/x-m4a" url="http://example.com/podcasts/everything/AllAboutEverythingEpisode3.m4a"/>
            <guid>http://example.com/podcasts/archive/aae20140615.m4a</guid>
            <pubDate>Tue, 08 Mar 2016 12:00:00 GMT</pubDate>
            <itunes:duration>07:04</itunes:duration>
            <itunes:explicit>no</itunes:explicit>
        </item>
  </channel>
</rss>
```

## Books

### Developing Feeds with RSS and Atom, by Ben Hammersley

* [O'Reilly](http://shop.oreilly.com/product/9780596008819.do)
* [goodreads](https://www.goodreads.com/book/show/926310.Developing_Feeds_with_Rss_and_Atom)
* [example source](https://resources.oreilly.com/examples/9780596008819/)

Getting the examples source:

```
git clone https://resources.oreilly.com/examples/9780596008819/ example_source/hammersley
```

### RSS and Atom By Heinz Wittenbrink

* [O'Reilly](http://shop.oreilly.com/product/9781904811572.do)
* [goodreads](https://www.goodreads.com/book/show/926313.Rss_and_Atom)
* [example source](https://resources.oreilly.com/examples/9781904811572/)

Getting the examples source:

```
git clone https://resources.oreilly.com/examples/9781904811572/ example_source/wittenbrink
```

## Credits and References

* [RSS and Atom - Understanding and Implementing Content Feeds and Syndication](https://www.goodreads.com/book/show/926313.Rss_and_Atom) - book
* [Developing Feeds with RSS and Atom](https://www.goodreads.com/book/show/926310.Developing_Feeds_with_Rss_and_Atom) - book
* [RSS](https://en.wikipedia.org/wiki/RSS) - wikipedia
* [Atom Syndication Format](https://en.wikipedia.org/wiki/Atom_(Web_standard)) - wikipedia
* [Introduction to Atom](https://validator.w3.org/feed/docs/atom.html)
* [Feed Validator](https://validator.w3.org)
* [Spec: iTunes Podcast RSS](https://github.com/simplepie/simplepie-ng/wiki/Spec:-iTunes-Podcast-RSS)
