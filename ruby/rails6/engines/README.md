# Engines in Rails 6

Looking into what is new or different with Rails 6 engines

## Notes

Notes - wip

### Checking Pre-requisites and Installation

```
$ node -v
v12.8.0
$ npm -v
ruby -v
sqlite3 --version6.10.2
$ ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin17]
$ sqlite3 --version
3.19.3 2017-06-27 16:48:08 2b0954060fe10d6de6d479287dd88890f1bef6cc1beca11bc6cdb79f72e2377b
$ gem install bundler
Successfully installed bundler-2.2.20
$ gem install rails
...
$ rails --version
Rails 6.1.3.2
```

### Making an Engine

```
rails plugin new blorgh --mountable
```

## Credits and References

* [Getting Started with Engines](https://guides.rubyonrails.org/engines.html)
* [Rails Engine not compiling assets unless explicitly declared](https://github.com/rails/sprockets/issues/542)
* [Rails Engine assests are not precompiled](https://stackoverflow.com/questions/35990897/rails-engine-assests-are-not-precompiled)
* [Newly created engine throws Sprockets::Rails::Helper::AssetNotPrecompiled](https://github.com/rails/rails/issues/40508)
