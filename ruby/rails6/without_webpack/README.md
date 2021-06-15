# Running Rails 6 Without Webpacker

Because sometimes just want to keep it simple with good old sprockets and the asset pipeline

## Notes

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

```
$ rails new pojacah --skip-webpack-install --skip-turbolinks
$ cd pojacah
$ rails db:migrate
```


good to go, but... it doesn't work:

```
$ rails server
...
/Users/paulgallagher/.rvm/gems/ruby-2.7.2@rails6_without_webpack/gems/webpacker-5.4.0/lib/webpacker/configuration.rb:103:in `rescue in load': Webpacker configuration file not found /Users/paulgallagher/MyGithub/LittleCodingKata/ruby/rails6/without_webpack/pojacah/config/webpacker.yml. Please run rails webpacker:install Error: No such file or directory @ rb_check_realpath_internal - /Users/paulgallagher/MyGithub/LittleCodingKata/ruby/rails6/without_webpack/pojacah/config/webpacker.yml (RuntimeError)

```


#### Manual Cleanup Required

Some webpack cleanup:

    rm -fR app/javascript

and remove webpacker from Gemfile:

    # gem 'webpacker', '~> 5.0'

ok, try again:

```
$ rails server
=> Booting Puma
=> Rails 6.1.3.2 application starting in development
=> Run `bin/rails server --help` for more startup options
Puma starting in single mode...
* Puma version: 5.3.2 (ruby 2.7.2-p137) ("Sweetnighter")
*  Min threads: 5
*  Max threads: 5
*  Environment: development
*          PID: 21204
* Listening on http://127.0.0.1:3000
* Listening on http://[::1]:3000
* Listening on http://127.94.0.2:3000
* Listening on http://127.94.0.1:3000
...
```

#### Adding a Welcome Page

Using controller generator:

```
bin/rails generate controller Welcome index
```

Adjust routes to use this as the main page.

#### More Manual Cleanup Required

Despite what the comments say, no, application.js is not being compiled.

    Rails.application.config.assets.precompile
     => ["manifest.js"]

add asset pipeline javascripts  to manifest.js:

    //= link_directory ../javascripts .js

and fixup the javascript include tag

    <%= javascript_include_tag 'application' %>

OK finally success.

More to do here, but for now that's all.

tldr: `--skip-webpack-install` still leaves lots of webpacker cruft lying around.
Perhaps a PR warranted after a bit more testing

## Credits and References

* [The Rails Command Line](https://guides.rubyonrails.org/command_line.html)
* [kirillshevch/rails_new_options_help.md](https://gist.github.com/kirillshevch/1b52f711e66b064416d746f07e834c00)
* [The Asset Pipeline](https://guides.rubyonrails.org/asset_pipeline.html)
* [How to disable/remove webpacker from a project?](https://github.com/rails/webpacker/issues/1333)
* [How to completely remove webpack and all its dependencies from Rails App](https://stackoverflow.com/questions/49107973/how-to-completely-remove-webpack-and-all-its-dependencies-from-rails-app)
