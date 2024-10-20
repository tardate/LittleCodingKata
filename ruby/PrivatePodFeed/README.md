# #091 PodFeed

Publishing a private podcast feed with Sinatra.

## Notes

I have some old audiobook CDs ripped to mp3. I used to sync these to an iPod, but when my last iPod battery failed
I gave in to streaming. Being able to load these books into my podcast app on the phone would be ideal though.
Podcast apps are perfect for this (as opposed to the standard media player) as they support features like adjustable playback speed.

This is a quick and dirty Sinatra application that turns one or more folders into podcast feeds (one for each folder).
It assumes the folders contain MP3s, and it reads the metadata from the files to generate feed and item names.
It also proxies the request to download the enclosure file.

I've used this to successfully load a few old books onto my phone for reading.

A couple of things to note:

* there's no security on the app
* it has a big security hole (possible to get it to download any file from your disk)

So if you want to use this, only use the app on a secured internal network, and don't leave it running.

## Running the Example

To run the app locally:

    gem install bundler
    bundle install
    ruby app.rb

By default, the app lists pod feeds from the `sample_data` folder.
I've put there a couple of episodes for a couple of Librivox recordings for testing purposes (these are not added to the repository).

To use another folder, set the root path with `POD_ROOT` environment variable:

    POD_ROOT="/Alternate/Path" ruby app.rb

The application will bind to all interfaces on port 4567. The default [home page](http://localhost:4567) will list the available feeds:

![sample_home](./assets/sample_home.png?raw=true)

Use the feed links to subscribe in the podcast application. A raw feed looks like this:

    $ curl http://my-mac.local:4567/feed/LibriVox_%20my-man-jeeves-by-p-g-wodehouse.xml
    <?xml version="1.0" encoding="UTF-8"?>
    <rss version="2.0"
      xmlns:content="http://purl.org/rss/1.0/modules/content/"
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
      xmlns:trackback="http://madskills.com/public/xml/rss/module/trackback/">
      <channel>
        <title>PPF: LibriVox: my-man-jeeves-by-p-g-wodehouse</title>
        <link>http://my-mac.local:4567</link>
        <description>LibriVox: my-man-jeeves-by-p-g-wodehouse</description>
        <pubDate>Fri, 12 Jul 2024 18:19:55 +0800</pubDate>
        <item>
          <title>01_my-man-jeeves-by-p-g-wod</title>
          <link>http://my-mac.local:4567</link>
          <enclosure url="http://my-mac.local:4567/content/LibriVox_%20my-man-jeeves-by-p-g-wodehouse/01_my-man-jeeves-by-p-g-wod.mp3"
            length="20749125"
            type="audio/mpeg"/>
          <pubDate>Tue, 31 Dec 2019 13:52:25 +0800</pubDate>
          <guid isPermaLink="false">01_my-man-jeeves-by-p-g-wod-1703738064</guid>
          <dc:date>2019-12-31T13:52:25+08:00</dc:date>
        </item>
        <item>
          <title>02_my-man-jeeves-by-p-g-wod</title>
          <link>http://my-mac.local:4567</link>
          <enclosure url="http://my-mac.local:4567/content/LibriVox_%20my-man-jeeves-by-p-g-wodehouse/02_my-man-jeeves-by-p-g-wod.mp3"
            length="20767083"
            type="audio/mpeg"/>
          <pubDate>Tue, 31 Dec 2019 13:52:25 +0800</pubDate>
          <guid isPermaLink="false">02_my-man-jeeves-by-p-g-wod-1703738065</guid>
          <dc:date>2019-12-31T13:52:25+08:00</dc:date>
        </item>
        <category>Books</category>
        <dc:date>2024-07-12T18:19:55+08:00</dc:date>
        <itunes:author>P.G. Wodehouse</itunes:author>
        <itunes:explicit>no</itunes:explicit>
      </channel>
    </rss>

## Credits and References

* [Create A Podcast XML Feed For Publishing To iTunes](https://www.thepolyglotdeveloper.com/2016/02/create-podcast-xml-feed-publishing-itunes/)
* [Spec: iTunes Podcast RSS](https://github.com/simplepie/simplepie-ng/wiki/Spec:-iTunes-Podcast-RSS)
* [Ruby RSS gem](https://github.com/ruby/rss)
* [Ruby id3tag gem](https://github.com/krists/id3tag)
* [Sinatra](https://sinatrarb.com/)
