# Console Barcharts

Print barcharts to the console in ascii or with unicode block elements

## Notes

I learned of the [barcharts gem](https://rubygems.org/gems/barcharts)
in [rubyweekly #492](https://rubyweekly.com/issues/492).

It's a pretty neat little utility for generating console barcharts.

Taking it for a quick test drive...

### Running the Example

The Gemfile specifies the gem requirements. `bundle install` as usual.

```
$ gem install bundler && bundle install
$ ./example.rb
Books Published/Year. Source: https://en.wikipedia.org/wiki/Books_published_per_country_per_year
By Country (unsorted)  (n=1943551)
---------------------------------
  Australia       ( 1%) |  28234
  Brazil          ( 2%) | * 57473
  China           (22%) | *********** 440000
  France          ( 4%) | ** 77986
  Germany         ( 4%) | ** 93600
  India           ( 4%) | ** 90000
  Indonesia       ( 4%) | ** 89000
  Italy           ( 3%) | * 61966
  Iran            ( 3%) | * 72871
  Japan           ( 7%) | *** 139078
  Russia          ( 5%) | ** 101981
  South Korea     ( 3%) | * 63476
  Spain           ( 2%) | * 44000
  Taiwan          ( 1%) |  28084
  Turkey          ( 3%) | * 66890
  United Kingdom  ( 9%) | **** 184000
  United States   (15%) | ******* 304912
By Country (block chars, sorted)  (n=1943551)
---------------------------------
  China           (22%) | ▉▉▉▉▉▉▉▉▉▉▉▎ 440000
  United States   (15%) | ▉▉▉▉▉▉▉▉ 304912
  United Kingdom  ( 9%) | ▉▉▉▉▊ 184000
  Japan           ( 7%) | ▉▉▉▋ 139078
  Russia          ( 5%) | ▉▉▋ 101981
  Germany         ( 4%) | ▉▉▍ 93600
  India           ( 4%) | ▉▉▎ 90000
  Indonesia       ( 4%) | ▉▉▎ 89000
  France          ( 4%) | ▉▉▏ 77986
  Iran            ( 3%) | ▉▉ 72871
  Turkey          ( 3%) | ▉▊ 66890
  South Korea     ( 3%) | ▉▋ 63476
  Italy           ( 3%) | ▉▋ 61966
  Brazil          ( 2%) | ▉▍ 57473
  Spain           ( 2%) | ▉▏ 44000
  Australia       ( 1%) | ▊ 28234
  Taiwan          ( 1%) | ▊ 28084
```

![example](./assets/example.png?raw=true)

## Credits and References

* [rubyweekly #492](https://rubyweekly.com/issues/492)
* [barcharts gem](https://rubygems.org/gems/barcharts)
* [barcharts](https://github.com/feedreader/pluto/tree/master/barcharts) - github
