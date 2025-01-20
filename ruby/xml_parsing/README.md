# #225 XML Parsing with Ruby

About techniques for working with XML, HTML4, and HTML5 from Ruby with gems like nokogiri.

## Notes

While XML and HTML is just text and so possible to work with it as string data,
better to use a gem that can handle all those cases like validation, encoding and semantic searching.

### Nokigiri

[Nokogiri (鋸)](https://nokogiri.org/) is the most popular tool for working with XML, HTML4, and HTML5 from Ruby.

#### HTML with Nokogiri

The `Nokogiri::XML` class provides entry point for XML parsing:

```ruby
source = 'https://nokogiri.org/tutorials/installing_nokogiri.html'
Nokogiri::HTML(URI.open(source))
```

See [nokogiri_html_test.rb](./nokogiri_html_test.rb) for test examples of HTML parsing, including for example:

* find by css `doc.css('nav ul.menu li a', 'article h2')`
* find by xpath `doc.xpath('//nav//ul//li/a', '//article//h2')`
* find with search `doc.search('nav ul.menu li a', '//article//h2')`

```bash
$ ./nokogiri_html_test.rb
Run options: --seed 3738

# Running:

...

Finished in 1.076714s, 2.7863 runs/s, 5.5725 assertions/s.

3 runs, 6 assertions, 0 failures, 0 errors, 0 skips
```

#### XML with Nokogiri

The `Nokogiri::XML` class provides entry point for XML parsing:

```ruby
source_file = Pathname.new(File.dirname(__FILE__)).join('data', 'planes.xml')
Nokogiri::XML(File.open(source_file))
```

See [nokogiri_xml_test.rb](./nokogiri_html_test.rb) for test examples of XML parsing, including for example:

* find by element name `doc.xpath("//model")`
* find by element attribute value `doc.xpath(%(//seller[@phone="555-222-3333"]))`
* find by element has child `doc.xpath(%(//ad[price]))`

```bash
$ ./nokogiri_xml_test.rb
Run options: --seed 60440

# Running:

...

Finished in 0.002498s, 1200.9608 runs/s, 2802.2419 assertions/s.

3 runs, 7 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [Nokogiri (鋸)](https://nokogiri.org/) - main site
* [nokogiri](https://rubygems.org/gems/nokogiri) - rubygems
* [nokogiri](https://nokogiri.org/rdoc/index.html) - api doc
* [XML Samples files](https://www.cs.utexas.edu/~mitra/csFall2010/cs329/lectures/xml.html) - borrowed from The University of Texas at Austin CS329 2010
* [Xpath cheatsheet](https://devhints.io/xpath)
