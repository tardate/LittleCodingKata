# #143 Console Tables

Generating data tables in the console from Array, Hash, or ActiveRecord objects with the tablesmith gem.

## Notes

I learned of the [tablesmith gem](https://rubygems.org/gems/tablesmith)
in [rubyweekly #492](https://rubyweekly.com/issues/492).

It's a pretty neat little utility for generating console tables.

Taking it for a quick test drive...

### Running the Example

The Gemfile specifies the gem requirements. `bundle install` as usual.

```
$ gem install bundler && bundle install
$ ./example.rb
Books Published/Year. Source: https://en.wikipedia.org/wiki/Books_published_per_country_per_year
+----------------+--------+
|    Country     | Books  |
+----------------+--------+
| Australia      | 28234  |
| Brazil         | 57473  |
| China          | 440000 |
| France         | 77986  |
| Germany        | 93600  |
| India          | 90000  |
| Indonesia      | 89000  |
| Italy          | 61966  |
| Iran           | 72871  |
| Japan          | 139078 |
| Russia         | 101981 |
| South Korea    | 63476  |
| Spain          | 44000  |
| Taiwan         | 28084  |
| Turkey         | 66890  |
| United Kingdom | 184000 |
| United States  | 304912 |
+----------------+--------+
Sorted:
+----------------+--------+
|    Country     | Books  |
+----------------+--------+
| China          | 440000 |
| United States  | 304912 |
| United Kingdom | 184000 |
| Japan          | 139078 |
| Russia         | 101981 |
| Germany        | 93600  |
| India          | 90000  |
| Indonesia      | 89000  |
| France         | 77986  |
| Iran           | 72871  |
| Turkey         | 66890  |
| South Korea    | 63476  |
| Italy          | 61966  |
| Brazil         | 57473  |
| Spain          | 44000  |
| Australia      | 28234  |
| Taiwan         | 28084  |
+----------------+--------+
```

## Credits and References

* [rubyweekly #492](https://rubyweekly.com/issues/492)
* [tablesmith gem](https://rubygems.org/gems/tablesmith)
* [tablesmith](https://github.com/livingsocial/tablesmith) - github
