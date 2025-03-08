# #310 Ruby 3.3

About Ruby 3.3 including installation on Apple Silicon.

## Notes

[Ruby 3.3](https://rubyreferences.github.io/rubychanges/3.3.html)
was [released on 2023-12-25](https://github.com/ruby/ruby/blob/ruby_3_3/NEWS.md).
As of 2024-11-05, [3.3.6](https://www.ruby-lang.org/en/news/2024/11/05/ruby-3-3-6-released/) is current stable.

Highlights

* it will become anonymous block argument in 3.4
* Module#set_temporary_name
* ObjectSpace::WeakKeyMap
* Range#overlap?
* Fiber#kill

### macOS (Apple Silicon) Install

```bash
$ rvm get head
...
$ rvm install ruby-3.3.3
Searching for binary rubies, this might take some time.
No binary rubies available for: osx/15.1/arm64/ruby-3.3.3.
Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
Checking requirements for osx.
Installing requirements for osx.
Updating system.......
Installing required packages: pkg-config.
Certificates bundle '/opt/homebrew/etc/openssl@3/cert.pem' is already up to date.
Requirements installation successful.
Installing Ruby from source to: /Users/username/.rvm/rubies/ruby-3.3.3, this may take a while depending on your cpu(s)...
ruby-3.3.3 - #downloading ruby-3.3.3, this may take a while depending on your connection...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 21.0M  100 21.0M    0     0  8375k      0  0:00:02  0:00:02 --:--:-- 8373k
ruby-3.3.3 - #extracting ruby-3.3.3 to /Users/username/.rvm/src/ruby-3.3.3.....
ruby-3.3.3 - #autogen.sh.
ruby-3.3.3 - #configuring....................................................................
ruby-3.3.3 - #post-configuration.
ruby-3.3.3 - #compiling................................................................................
ruby-3.3.3 - #installing................
ruby-3.3.3 - #making binaries executable...
Installed rubygems 3.5.11 is newer than 3.0.9 provided with installed ruby, skipping installation, use --force to force installation.
ruby-3.3.3 - #gemset created /Users/username/.rvm/gems/ruby-3.3.3@global
ruby-3.3.3 - #importing gemset /Users/username/.rvm/gemsets/global.gems..........................................................
ruby-3.3.3 - #generating global wrappers........
ruby-3.3.3 - #gemset created /Users/username/.rvm/gems/ruby-3.3.3
ruby-3.3.3 - #importing gemsetfile /Users/username/.rvm/gemsets/default.gems evaluated to empty gem list
ruby-3.3.3 - #generating default wrappers........
ruby-3.3.3 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-3.3.3 - #complete
Ruby was built without documentation, to build it run: rvm docs generate-ri
```

Checking version installed:

```bash
$ ruby -v
ruby 3.3.3 (2024-06-12 revision f1c7b6f435) [arm64-darwin24]
```

## Credits and References

* [Ruby 3.3 Release](https://github.com/ruby/ruby/blob/ruby_3_3/NEWS.md).
* [Ruby 3.3.6 Release News](https://www.ruby-lang.org/en/news/2024/11/05/ruby-3-3-6-released/)
* [About the Ruby 3.3 Release](https://rubyreferences.github.io/rubychanges/3.3.html)
