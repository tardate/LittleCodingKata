# Querying Atom Feeds

Techniques and examples for querying Atom Feeds with XPath and Nokogiri.

## Notes

The [Atom Syndication Format](https://en.wikipedia.org/wiki/Atom_(web_standard))
is an XML language used for web feeds. It emerged as a standard that intended to clean up some of the ambiguities in early RSS versions.
[RSS 2](https://validator.w3.org/feed/docs/rss2.html) regained supremacy, mainly because of its enclosure support allowing it to be used for podcasts.
These days feeds are generally either Atom or RSS 2, although the term "RSS" is often used to all feeds regardless of standard.

### Query the Feed

This is a simple demonstration of querying a feed using XPath.
Actually, what I really wanted to do was to count the number of entries in a feed that appeared in 2022 and had a specific category assigned.

I'm parsing the feed with [Nokogiri (鋸)](https://nokogiri.org/).

Visualising the feed structure and the elements to be queried:

```xml
<feed>
  ...
  <entry>
    <id>...</id>
    <link href="..."/>
    <updated>(iso8601 date matching specific year)</updated>
    <title>...</title>
    <summary>...</summary>
    <g:image_link>...</g:image_link>
    <category term="(matching specific term)"/>
    <category term="..."/>
  </entry>
```

### Namespaces

Atom feeds will have as a minimum an
[xmlns](https://validator.w3.org/feed/docs/atom.html)
Atom Syndication Format namespace.

XPath queries will need to correctly reference the namespace for elements (e.g. `//xmlns:entry`).
Nokogiri has a
[remove_namespaces!](https://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri%2FXML%2FDocument:remove_namespaces!)
method that can be used to strip namespace details and allow queries to ignore namespaces for simplicity.

### Matching Entries By Category

Category elements have the category name as an attribute called `term`. So categories can be retrieved with XPath query:

```ruby
feed.xpath(%(//xmlns:category[@term="scale models"]))
```

However this returns the category element itself. Getting the associated entry will require a further `.parent` operation.

Entries may be retrieved directly with a modified query. Essentially meaning "get entries having a category child element having a term attribute matching this value":

```ruby
feed.xpath(%(//xmlns:entry[xmlns:category[@term="scale models"]]))
```

### Filtering By Year

Each entry in the feed has an `updated` element with date/time encoded in iso8601 format.

The naïve approach is to iterate entries with ruby and collect only those with a matching date.
This is simple and effective, as all the complexities of dates can be easily handled in ruby. e.g.

```ruby
result = feed.xpath(%(//xmlns:entry[xmlns:category[@term="scale models"]])).each_with_object([]) do |entry, memo|
  updated = Time.parse entry.at('updated').content
  memo << entry if updated.year == 2022
end
```

This could also be implemented as an XPath function. Nokogiri allows custom XPath functions to be defined,
for [example here](https://gist.github.com/knu/087b7f89bb31de4f419c).
I have not tried this yet.

But can this query be achieved with standard XPath functions?

* XPath and XQuery Functions and Operators 3.1 defines a range of date/time functions including [gYear-equal](https://www.w3.org/TR/xpath-functions-31/#func-gYear-equal). TBH I'm still trying to wrap my head around how these and whether they are actually supported. TODO: investigate further

Since I am only trying to match the year, I could just fallback on string matches using the
[starts-with](https://developer.mozilla.org/en-US/docs/Web/XPath/Functions/starts-with) function. This works nicely:
"get all entries having a updated child element starting with `2002-`":

```ruby
feed.xpath(%(//xmlns:entry[starts-with(xmlns:updated, "2022-")]))
```

### Combined Queries

The category and updated queries can be combined into a single XPath expression meaning
"get all entries having a category child element having a term attribute matching this value and having a updated child element starting with `2002-`":

```ruby
feed.xpath(%(//xmlns:entry[xmlns:category[@term="scale models"]][starts-with(xmlns:updated, "2022-")]))
```

### Testing Examples

All the techinques discussed here are demonstrated in the [atom_feeds_test.rb](./atom_feeds_test.rb) script

```sh
$ ./atom_feeds_test.rb
Run options: --seed 64226

# Running:

.........

Finished in 0.829873s, 10.8450 runs/s, 21.6901 assertions/s.

9 runs, 18 assertions, 0 failures, 0 errors, 0 skips
```

### Making My Query

So the answer to my original question is "39" - the number of scale model posts updated in 2022.

NB: the answer I was actually after is "36 scale model posts created in 2022", however there is no created/published date in the feed.
The results of my query included 3 entries that were updated in 2022 but created in 2021. I just had to manually exclude those.

```sh
$ ./leap_2022_scale_models.rb
Found 39 projects updated in 2022 tagged with 'scale models'
#678 In Spring
#677 wz. 34
#673 Empire in Decay - Victor III
#672 J-20
#671 Mitsubishi Ki-46 Trainer
#669 PLAN Type 051C
#666 Axis Of Chess
#665 ORP Ślązak
#662 Tachikawa KKY-1
#661 Concorde
#660 WarHawk 40K
#659 Stridsvagn 103
#658 CA-19 Boomerang
#657 Flying Tigers Egg-Scale
#655 HMS Revenge
#654 IJN No.13 Sub-chaser
#652 Daihatsu Midget
#651 TS-11 Iskra
#650 Mongol Warriors
#649 P-40B Flying Tiger in 1:144
#648 P-40B Flying Tiger in 1:72
#646 Fairey Gannet
#645 Tachikawa Ki-55
#644 Ukrainian Cossack
#641 Fubuki
#639 Spitfire Mk.XIV
#638 Man Overboard
#634 Nakajima B5N2 Kate
#630 Spitfire Mk.Vc
#628 Westland Lynx
#627 Vauxhall D-Type Ambulance
#626 Blackburn Buccaneer S.2C
#623 Wirraway
#622 T34 1942
#621 KubelMagic
#618 Chengdu J-10S
#609 JF-17
#607 PZL P.7a
#581 PLA Navy Type 054A
```

The [leap_2022_scale_models.rb](./leap_2022_scale_models.rb) script:

```ruby
require 'nokogiri'
require 'open-uri'

source = 'https://leap.tardate.com/catalog/atom.xml'
target_term = 'scale models'
target_year = 2022

feed = Nokogiri::XML(URI.open(source))
projects = feed.xpath(%(//xmlns:entry[xmlns:category[@term="#{target_term}"]][starts-with(xmlns:updated, "#{target_year}-")]))

puts "Found #{projects.size} projects updated in #{target_year} tagged with '#{target_term}'"
projects.each do |project|
  puts project.at('title').content
end
```

## Credits and References

* [Nokogiri (鋸)](https://nokogiri.org/) - main site
* [nokogiri](https://rubygems.org/gems/nokogiri) - rubygems
* [nokogiri](https://nokogiri.org/rdoc/index.html) - api doc
* [Atom (web standard)](https://en.wikipedia.org/wiki/Atom_(web_standard))
* [Atom Feed Validation Service](https://validator.w3.org/feed/docs/atom.html)
* [RSS 2 Feed Validation Service](https://validator.w3.org/feed/docs/rss2.html)
