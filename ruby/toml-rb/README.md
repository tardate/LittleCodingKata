# #497 toml-rb

Quick review and test of the toml-rb gem for parsing and dumping TOML files.

## Notes

[TOML](https://toml.io/en/) (Tom's Obvious, Minimal Language) is a human-readable configuration file format designed
as a standardized, less ambiguous alternative to INI files, YAML, and JSON.

It is perhaps most commonly encountered as configuration for rust projects.

The [toml-rb gem](https://rubygems.org/gems/toml-rb) is a pure Ruby TOML parser and dumper with no runtime dependencies.

## A Quick Test

I've specified the gem in a [Gemfile](./Gemfile), so install with bundler:

```sh
$ bundle install
Fetching gem metadata from https://rubygems.org/...
Resolving dependencies...
Fetching toml-rb 6.0.0
Installing toml-rb 6.0.0
Bundle complete! 1 Gemfile dependency, 1 gem now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

The [example.rb](./example.rb) demonstrates reading [data/example.toml](./data/example.toml):

```sh
$ ./example.rb data/example.toml

## Parsed TOML from data/example.toml:
{"title" => "TomlRB Example",
 "owner" =>
  {"name" => "Tom Preston-Werner",
   "organization" => "GitHub",
   "bio" => "GitHub Cofounder & CEO\n" + "Likes tater tots and beer.",
   "dob" => 1979-05-27 07:32:00 +0000},
 "database" =>
  {"server" => "192.168.1.1",
   "ports" => [8001, 8001, 8002],
   "connection_max" => 5000,
   "enabled" => true},
 "servers" =>
  {"alpha" => {"ip" => "10.0.0.1", "dc" => "eqdc10"},
   "beta" => {"ip" => "10.0.0.2", "dc" => "eqdc10"}},
 "clients" =>
  {"data" => [["gamma", "delta"], [1, 2]], "hosts" => ["alpha", "omega"]},
 "amqp" => {"exchange" => {"durable" => true, "auto_delete" => false}},
 "products" =>
  [{"name" => "Hammer", "sku" => 738594937},
   {},
   {"name" => "Nail", "sku" => 284758393, "color" => "gray"}]}

## Dumped back to TOML:
title = "TomlRB Example"
[amqp.exchange]
auto_delete = false
durable = true
[clients]
data = [["gamma", "delta"], [1, 2]]
hosts = ["alpha", "omega"]
[database]
connection_max = 5000
enabled = true
ports = [8001, 8001, 8002]
server = "192.168.1.1"
[owner]
bio = "GitHub Cofounder & CEO\nLikes tater tots and beer."
dob = 1979-05-27T07:32:00Z
name = "Tom Preston-Werner"
organization = "GitHub"
[servers.alpha]
dc = "eqdc10"
ip = "10.0.0.1"
[servers.beta]
dc = "eqdc10"
ip = "10.0.0.2"
[[products]]
name = "Hammer"
sku = 738594937
[[products]]
[[products]]
color = "gray"
name = "Nail"
sku = 284758393
```

The code for this is trivial. Only two methods:

```ruby
parsed = TomlRB.load_file(filename)
...
TomlRB.dump(parsed)
```

## Credits and References

* [TOML](https://toml.io/en/)
* toml-rb
    * <https://github.com/emancu/toml-rb>
    * <https://rubygems.org/gems/toml-rb>
