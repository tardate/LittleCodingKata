# #156

Learning about the Doorkeeper gem and testing it for adding OAuth2 provider capabilities to Rails applications.

## Notes

Doorkeeper is an oAuth2 provider built in Ruby:

* integrates with Ruby on Rails and Grape frameworks.
* requires Ruby Rails 5 or higher
* Supported features:
  - The OAuth 2.0 Authorization Framework
      - Authorization Code Flow
      - Access Token Scopes
      - Refresh token
      - Implicit grant
      - Resource Owner Password Credentials
      - Client Credentials
  - OAuth 2.0 Token Revocation
  - OAuth 2.0 Token Introspection
  - OAuth 2.0 Threat Model and Security Considerations
  - OAuth 2.0 for Native Apps
  - Proof Key for Code Exchange by OAuth Public Clients

Extensions:

* [OpenID Connect extension](https://doorkeeper-gem/doorkeeper-openid_connect)
* [JWT Token support](https://github.com/doorkeeper-gem/doorkeeper-jwt)
* [Assertion grant extension](https://github.com/doorkeeper-gem/doorkeeper-grants_assertion)
* [I18n translations](https://github.com/doorkeeper-gem/doorkeeper-i18n) - adds translations for errors and administrative actions

### Running the Samples


#### Doorkeeper Provider App

The [Doorkeeper Demo Provider App](https://github.com/doorkeeper-gem/doorkeeper-provider-app)
is an example of an OAuth 2 provider using Doorkeeper gem, Rails 5.2 and Devise.

Grabbing the source and install:

```
$ git clone git://github.com/doorkeeper-gem/doorkeeper-provider-app.git
$ cd doorkeeper-provider-app
$ bundle
```

Seed the app with sample data:

```
$ bundle exec rake db:setup
warning: parser/current is loading parser/ruby26, which recognizes
warning: 2.6.6-compliant syntax, but you are running 2.6.5.
warning: please see https://github.com/whitequark/parser#compatibility-with-ruby-mri.
Created database 'db/development.sqlite3'
Created database 'db/test.sqlite3'
Application:
name: Doorkeeper Sinatra Client
redirect_uri: https://doorkeeper-sinatra.herokuapp.com/callback
uid: YLnVhB2JHgzbFig8PoqYQgPGx2qICqDCmaBDVPIdZDY
secret: YWW2gABlgoj6xbNdlrXXF5CjSjvj-QCCLnJv5LCi6W8
```

Start the app with `rails server` and load [localhost:3000](http://localhost:3000):

![doorkeeper-provider-app-1](./assets/doorkeeper-provider-app-1.png?raw=true)

#### Doorkeeper Sinatra Client

The [Doorkeeper Demo Sinatra Client](https://github.com/doorkeeper-gem/doorkeeper-sinatra-client)
is an example of OAuth 2 client.

Grabbing the source and install:

```
git clone git://github.com/applicake/doorkeeper-sinatra-client.git
doorkeeper-sinatra-client
bundle
```

First, make sure the application is correctly registered in the provider, and get the keys.
From
[http://localhost:3000/oauth/applications/1](http://localhost:3000/oauth/applications/1),
the "confidential" application (used where the client secret can be kept confidential):

![doorkeeper-provider-app-sinatra-client-1](./assets/doorkeeper-provider-app-sinatra-client-1.png?raw=true)

And creating another non-confidential version of the app (used by Native mobile apps and Single Page Apps where the client secret cannot be kept confidential)

![doorkeeper-provider-app-sinatra-client-public-1](./assets/doorkeeper-provider-app-sinatra-client-public-1.png?raw=true)

Creating a `.env` file (automatically by the app) with required settings:

```
$ cat .env
PUBLIC_CLIENT_ID                 = "MzqP76I9zGAhEkEJTEdhwBmeqM7JQHwD_9VOsF6fbm8"
PUBLIC_CLIENT_REDIRECT_URI       = "KZSq1UWAnl78VeE7d_EsV6DRBJCv9Ec6AvY2Y0RCklk"
CONFIDENTIAL_CLIENT_ID           = "YLnVhB2JHgzbFig8PoqYQgPGx2qICqDCmaBDVPIdZDY"
CONFIDENTIAL_CLIENT_SECRET       = "YWW2gABlgoj6xbNdlrXXF5CjSjvj-QCCLnJv5LCi6W8"
CONFIDENTIAL_CLIENT_REDIRECT_URI = "http://localhost:9292/callback"
PROVIDER_URL = "http://localhost:3000"
```

Start the Sinatra app `bundle exec rackup config.ru` and load the app at [localhost:9292](http://localhost:9292):

![sinatra-client-1](./assets/sinatra-client-1.png?raw=true)

#### Confidential Client Authentication

After clicking "Sign in on localhost", I am redirected to the provider app
and challenged to sign-in (because I have not done that yet):

![sinatra-client-confidential-access-1](./assets/sinatra-client-confidential-access-1.png?raw=true)

Once signed-in, I must authorised the calling app:

![sinatra-client-confidential-access-2](./assets/sinatra-client-confidential-access-2.png?raw=true)

Then returned to the calling app, successfully signed-in:

![sinatra-client-confidential-access-3](./assets/sinatra-client-confidential-access-3.png?raw=true)


#### Public Client Authentication

After clicking "Sign in with the public client on localhost", I am redirected to the provider app
and challenged to sign-in (because I have not done that yet):

![sinatra-client-public-access-1](./assets/sinatra-client-public-access-1.png?raw=true)

Once signed-in, I must authorised the calling app:

![sinatra-client-public-access-2](./assets/sinatra-client-public-access-2.png?raw=true)

Then returned to the calling app, successfully signed-in:

![sinatra-client-public-access-3](./assets/sinatra-client-public-access-3.png?raw=true)


#### Managing Authorized Applications

After the authentications performed above, I can see the authorized applications
at  [http://localhost:3000/oauth/authorized_applications](http://localhost:3000/oauth/authorized_applications):

![doorkeeper-provider-app-2](./assets/doorkeeper-provider-app-2.png?raw=true)


#### Doorkeeper Devise Client

The [Doorkeeper Demo Devise Client](https://github.com/doorkeeper-gem/doorkeeper-devise-client)
is an example of a rails+devise+omniauth application that acts as an OAuth2 client.


Grabbing the source and install:

```
git clone git@github.com:doorkeeper-gem/doorkeeper-devise-client.git
doorkeeper-devise-client
bundle
bundle exec rake db:migrate
```

NB: due to the recent release of omniauth 2.0.0, `devise` and `omniauth-auth` dependencies are a bit broken.
See [https://github.com/heartcombo/devise/issues/5326](https://github.com/heartcombo/devise/issues/5326).
Temporarily just added a further constraint to the Gemfile:

```
gem "omniauth", ">= 1.9", "< 2"
```

The app needs to be registered in the provider as "confidential" and with a
callback url with path component of `/users/auth/doorkeeper/callback`

![doorkeeper-provider-app-devise-client-1](./assets/doorkeeper-provider-app-devise-client-1.png?raw=true)

Using these details to add a `.env` file for the application:

```
$ cat .env
DOORKEEPER_APP_ID = "b9wv3zaHtSFu0hNusqRppCLyg4BslVtcaEegGc-dANw"
DOORKEEPER_APP_SECRET = "LgF108FvuXqYAoKZK7esT96r4AWiAbCYuJvmYapRePE"
DOORKEEPER_APP_URL = "http://localhost:3000"
```

Start the app `rails s -p 3232` and load the app at [localhost:3232](http://localhost:3232):

![devise-client-1](./assets/devise-client-1.png?raw=true)

After clicking "Sign in with OAuth 2 provider", I am redirected to the provider app
and challenged to sign-in (because I have not done that yet):


![devise-client-auth-1](./assets/devise-client-auth-1.png?raw=true)

Once signed-in, I must authorised the calling app:

![devise-client-auth-2](./assets/devise-client-auth-2.png?raw=true)

Then returned to the calling app, successfully signed-in:

![devise-client-auth-3](./assets/devise-client-auth-3.png?raw=true)



### Building a Rails 6 App with OAuth Provider

#### Build a Skeleton Rails 6 App

Checking Pre-requisites and Installation

```
$ node -v
v12.8.0
$ npm -v
6.10.2
$ ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin17]
$ sqlite3 --version
3.19.3 2017-06-27 16:48:08 2b0954060fe10d6de6d479287dd88890f1bef6cc1beca11bc6cdb79f72e2377b
$ gem install rails -v 6.1.1
...
$ rails --version
Rails 6.1.1
```

The basic app:

```
$ rails new demo-provider
...
$ cp .ruby-gemset demo-provider # to keep the app within the same gemset
$ cd demo-provider
$ rm -fR .git # --skip-git would do this, but also means no .gitignore generated

$ rails generate controller Welcome index
$ rails generate scaffold Article title:string text:text
$ rails db:migrate
```

Add the [devise](https://rubygems.org/gems/devise) gem to the `Gemfile` and `bundle install`

```
$ rails generate devise:install
$ rails generate devise:views
$ rails generate devise User
$ rails db:migrate
```

Minimal customisation of the app:

* add `before_action :authenticate_user!` to the `ArticlesController`
* add `root 'welcome#index'` to `routes.rb`
* add sign in/out links to `application.html.erb`

Basic app is working:

![demo-provider-1](./assets/demo-provider-1.png?raw=true)


Adding doorkeeper:

```
$ bundle add doorkeeper
bundle exec rails generate doorkeeper:install
```

Configure resource_owner_authenticator block for devise auth in `config/initializers/doorkeeper.rb`.

Choose ActiveRecord as the ORM:

```
rails generate doorkeeper:migration
rails db:migrate
```

Add some links to the application layout:

![demo-provider-2](./assets/demo-provider-2.png?raw=true)

#### Testing with the Doorkeeper Devise Client

Add the scopes to `config/initializers/doorkeeper.rb` that are expected by the Doorkeeper Devise Client:

```
default_scopes :read
optional_scopes :write
```

Add support for `/api/v1/me.json`

Register the "Doorkeeper Devise Client" as a new client application:

![demo-provider-3](./assets/demo-provider-3.png?raw=true)


Update the doorkeeper-devise-client `.env` file with these settings:

```
$ cat .env
DOORKEEPER_APP_ID = "OmTd4AwOdyGtSjax0EM41Q92aAjTLoPLB4shbT5ItqI"
DOORKEEPER_APP_SECRET = "9v2Ys2ZYZGZ4lMqWJqUU6l3DHrIiP0uY80_2R1qpsbk"
DOORKEEPER_APP_URL = "http://localhost:3000"
```

Startup the doorkeeper-devise-client app `rails s -p 3232` and load it at [localhost:3232](http://localhost:3232).

OAuth signs in successfully:

![demo-provider-4](./assets/demo-provider-4.png?raw=true)


## Credits and References

* [Doorkeeper Guides](https://doorkeeper.gitbook.io/guides/)
* [doorkeeper](https://rubygems.org/gems/doorkeeper) - rubygems
* [doorkeeper](https://github.com/doorkeeper-gem/doorkeeper) - github
* [Doorkeeper Demo Provider App](https://github.com/doorkeeper-gem/doorkeeper-provider-app)
* [Doorkeeper Demo Sinatra Client](https://github.com/doorkeeper-gem/doorkeeper-sinatra-client)
* [Doorkeeper Demo Devise Client](https://github.com/doorkeeper-gem/doorkeeper-devise-client)
