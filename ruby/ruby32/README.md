# #309 Ruby 3.2

About Ruby 3.2 including installation on Apple Silicon.

## Notes

[Ruby 3.2](https://rubyreferences.github.io/rubychanges/3.2.html)
was [released on 2022-12-25](https://github.com/ruby/ruby/blob/ruby_3_2/NEWS.md).
As of 2024-10-30, [3.2.6 is the latest](https://www.ruby-lang.org/en/news/2024/10/30/ruby-3-2-6-released/).

Highlights:

* Anonymous method argument passing
* More inspectable refinements
* Data class
* Support for pattern-matching in Time and MatchData
* Set is a built-in class
* Per-Fiber storage
* RubyVM::AbstractSyntaxTree: fault-tolerant and token-level parsing

### MacOS (Apple Silicon) Install

```bash
$ rvm install ruby-3.2.2
Searching for binary rubies, this might take some time.
No binary rubies available for: osx/15.1/arm64/ruby-3.2.2.
Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
Checking requirements for osx.
Installing requirements for osx.
Updating system.......
Installing required packages: pkg-config.
Certificates bundle '/opt/homebrew/etc/openssl@1.1/cert.pem' is already up to date.
Requirements installation successful.
Installing Ruby from source to: /Users/username/.rvm/rubies/ruby-3.2.2, this may take a while depending on your cpu(s)...
ruby-3.2.2 - #downloading ruby-3.2.2, this may take a while depending on your connection...
ruby-3.2.2 - #extracting ruby-3.2.2 to /Users/username/.rvm/src/ruby-3.2.2.....
ruby-3.2.2 - #autogen.sh.
ruby-3.2.2 - #configuring....................................................................
ruby-3.2.2 - #post-configuration.
ruby-3.2.2 - #compiling........................................................................................................
Error running '__rvm_make -j8',
please read /Users/username/.rvm/log/1731471960_ruby-3.2.2/make.log

There has been an error while running make. Halting the installation.
```

Examining the log, it's tripping over OpenSSL `make[1]: *** [ext/openssl/all] Error 2`

Forcing the install to find the correct brew-installed OpenSSL libs works:

```bash
$ rvm install ruby-3.2.2 --with-openssl-dir=`brew --prefix openssl`
ruby-3.2.2 - #removing src/ruby-3.2.2..
Checking requirements for osx.
Installing requirements for osx.
Updating system.......
Installing required packages: pkg-config.
Certificates bundle '/opt/homebrew/etc/openssl@1.1/cert.pem' is already up to date.
Requirements installation successful.
Installing Ruby from source to: /Users/username/.rvm/rubies/ruby-3.2.2, this may take a while depending on your cpu(s)...
ruby-3.2.2 - #downloading ruby-3.2.2, this may take a while depending on your connection...
ruby-3.2.2 - #extracting ruby-3.2.2 to /Users/username/.rvm/src/ruby-3.2.2.....
ruby-3.2.2 - #autogen.sh.
ruby-3.2.2 - #configuring....................................................................
ruby-3.2.2 - #post-configuration.
ruby-3.2.2 - #compiling....................................................................................................
ruby-3.2.2 - #installing...............
ruby-3.2.2 - #making binaries executable...
Installed rubygems 3.4.10 is newer than 3.0.9 provided with installed ruby, skipping installation, use --force to force installation.
ruby-3.2.2 - #gemset created /Users/username/.rvm/gems/ruby-3.2.2@global
ruby-3.2.2 - #importing gemset /Users/username/.rvm/gemsets/global.gems..........................................................
ruby-3.2.2 - #generating global wrappers........
ruby-3.2.2 - #gemset created /Users/username/.rvm/gems/ruby-3.2.2
ruby-3.2.2 - #importing gemsetfile /Users/username/.rvm/gemsets/default.gems evaluated to empty gem list
ruby-3.2.2 - #generating default wrappers........
ruby-3.2.2 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-3.2.2 - #complete
Ruby was built without documentation, to build it run: rvm docs generate-ri
$ ruby -v
ruby 3.2.2 (2023-03-30 revision e51014f9c0) [arm64-darwin24]
```

I later discovered that the installation error can been overcome by updating rvm:

```bash
$ rvm uninstall ruby-3.2.2
...
$ rvm get head
...
$ rvm install ruby-3.2.2
Searching for binary rubies, this might take some time.
No binary rubies available for: osx/15.1/arm64/ruby-3.2.2.
Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
Checking requirements for osx.
Installing requirements for osx.
Updating system.......
Installing required packages: pkg-config.
Certificates bundle '/opt/homebrew/etc/openssl@3/cert.pem' is already up to date.
Requirements installation successful.
Installing Ruby from source to: /Users/username/.rvm/rubies/ruby-3.2.2, this may take a while depending on your cpu(s)...
ruby-3.2.2 - #downloading ruby-3.2.2, this may take a while depending on your connection...
ruby-3.2.2 - #extracting ruby-3.2.2 to /Users/username/.rvm/src/ruby-3.2.2.....
ruby-3.2.2 - #autogen.sh.
ruby-3.2.2 - #configuring....................................................................
ruby-3.2.2 - #post-configuration.
ruby-3.2.2 - #compiling...................................................................................................
ruby-3.2.2 - #installing...............
ruby-3.2.2 - #making binaries executable...
Installed rubygems 3.4.10 is newer than 3.0.9 provided with installed ruby, skipping installation, use --force to force installation.
ruby-3.2.2 - #gemset created /Users/username/.rvm/gems/ruby-3.2.2@global
ruby-3.2.2 - #importing gemset /Users/username/.rvm/gemsets/global.gems..........................................................
ruby-3.2.2 - #generating global wrappers........
ruby-3.2.2 - #gemset created /Users/username/.rvm/gems/ruby-3.2.2
ruby-3.2.2 - #importing gemsetfile /Users/username/.rvm/gemsets/default.gems evaluated to empty gem list
ruby-3.2.2 - #generating default wrappers........
ruby-3.2.2 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-3.2.2 - #complete
Ruby was built without documentation, to build it run: rvm docs generate-ri
```

Checking version installed:

```bash
$ ruby -v
ruby 3.2.2 (2023-03-30 revision e51014f9c0) [arm64-darwin24]
```

### Updating to 3.2.6

```bash
$ rvm get head
...
$ rvm install ruby-3.2.6
Searching for binary rubies, this might take some time.
No binary rubies available for: osx/15.1/arm64/ruby-3.2.6.
Continuing with compilation. Please read 'rvm help mount' to get more information on binary rubies.
Checking requirements for osx.
Installing requirements for osx.
Updating system.......
Installing required packages: pkg-config.
Certificates bundle '/opt/homebrew/etc/openssl@3/cert.pem' is already up to date.
Requirements installation successful.
Installing Ruby from source to: /Users/paulgallagher/.rvm/rubies/ruby-3.2.6, this may take a while depending on your cpu(s)...
ruby-3.2.6 - #downloading ruby-3.2.6, this may take a while depending on your connection...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 19.5M  100 19.5M    0     0  4992k      0  0:00:04  0:00:04 --:--:-- 4992k
ruby-3.2.6 - #extracting ruby-3.2.6 to /Users/paulgallagher/.rvm/src/ruby-3.2.6.....
ruby-3.2.6 - #autogen.sh.
ruby-3.2.6 - #configuring....................................................................
ruby-3.2.6 - #post-configuration.
ruby-3.2.6 - #compiling....................................................................................................
ruby-3.2.6 - #installing...............
ruby-3.2.6 - #making binaries executable...
Installed rubygems 3.4.19 is newer than 3.0.9 provided with installed ruby, skipping installation, use --force to force installation.
ruby-3.2.6 - #gemset created /Users/paulgallagher/.rvm/gems/ruby-3.2.6@global
ruby-3.2.6 - #importing gemset /Users/paulgallagher/.rvm/gemsets/global.gems..........................................................
ruby-3.2.6 - #generating global wrappers........
ruby-3.2.6 - #gemset created /Users/paulgallagher/.rvm/gems/ruby-3.2.6
ruby-3.2.6 - #importing gemsetfile /Users/paulgallagher/.rvm/gemsets/default.gems evaluated to empty gem list
ruby-3.2.6 - #generating default wrappers........
ruby-3.2.6 - #adjusting #shebangs for (gem irb erb ri rdoc testrb rake).
Install of ruby-3.2.6 - #complete
Ruby was built without documentation, to build it run: rvm docs generate-ri
```

Checking version installed:

```bash
$ ruby -v
ruby 3.2.6 (2024-10-30 revision 63aeb018eb) [arm64-darwin24]
```

## Credits and References

* [Ruby 3.2 Release](https://github.com/ruby/ruby/blob/ruby_3_2/NEWS.md).
* [Ruby 3.2.6 Release News](https://www.ruby-lang.org/en/news/2024/10/30/ruby-3-2-6-released/)
* [About the Ruby 3.2 Release](https://rubyreferences.github.io/rubychanges/3.2.html)
