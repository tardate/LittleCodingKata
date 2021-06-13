# Rails 6 with Docker

All about running Rails 6 with Docker

## Notes

Running Rails with Docker is a great solution for both development (eliminates any reliance on local system dependencies)
and for deployment (no ruby or rails specific dependencies for operations to deal with).

These notes cover a few examples of running Rails 6 application in Docker,
with solutions for some common Rails-specific refinements.

## Running docker-compose-rails-6 example

The [github.com/DiveIntoHacking/docker-compose-rails-6](https://github.com/DiveIntoHacking/docker-compose-rails-6)
repo is a simple pre-fab example. Runs just as advertized...


```
$ git clone git@github.com:DiveIntoHacking/docker-compose-rails-6.git
$ cd docker-compose-rails-6
$ docker-compose run --rm web bundle install
$ docker-compose run --rm web yarn install
$ docker-compose up
$ docker-compose exec web ./bin/rails db:create
```

And it is running OK on `http://localhost:3000` ..

![DiveIntoHacking_initial_local](./assets/DiveIntoHacking_initial_local.png?raw=true)

Cleaning up..

```
$ docker-compose down
Removing docker-compose-rails-6_web_1 ... done
Removing docker-compose-rails-6_db_1  ... done
Removing network docker-compose-rails-6_default
```

A couple of things to note about this configuration:

* the app folder is mapped to local file system
* bundle and yarn installs assets in `vender/bundle` and `node_modules` i.e. these are not shipped in the image. This is not really ideal for deployment, as runtime dependencies could change from test and build-time.

## Building a New Image From a Local Installation

Let's start from scratch, with the basic aim of having a rails application that can:

* run in the local OS as normal for development and testing
* run in docker for development and testing

At the time of writing, I'm using Ruby 2.7.1 and Rails 6.0.3.3

### Step 1: Build a Basic App (Local)

#### Checking Pre-requisites and Installation

```
$ node -v
v12.8.0
$ npm -v
6.10.2
$ ruby -v
ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-darwin17]
$ gem install rails -v 6.0.3.3
...
$ rails --version
Rails 6.0.3.3
$ docker --version
Docker version 19.03.12, build 48a66213fe
```

Out-of-the-box application generation, built locally and using a local PostgreSQL database:

```
$ rails new minime --database=postgresql
$ cd minime
```

The `rails new` takes care of dependency installation. To recreate or install elsewhere, install dependencies:

```
bundle install
yarn install
```

Create and migrate the database, then fire up the app...
```
$ rails db:create
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
Created database 'minime_development'
Created database 'minime_test'
```

NB: get rid of the tzinfo-data platform warning with `bundle config --local disable_platform_warnings true`


```
$ rails db:migrate
$ rails server
=> Booting Puma
=> Rails 6.0.3.4 application starting in development
=> Run `rails server --help` for more startup options
Puma starting in single mode...
* Version 4.3.6 (ruby 2.7.1-p83), codename: Mysterious Traveller
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://127.0.0.1:3000
* Listening on tcp://[::1]:3000
* Listening on tcp://127.94.0.2:3000
* Listening on tcp://127.94.0.1:3000
Use Ctrl-C to stop
```

And it is running OK on `http://localhost:3000` ..

![web_initial_local](./assets/web_initial_local.png?raw=true)


Adding a few more features (including tests)

```
rails generate controller Articles
rails generate model Article title:string text:text
rails db:migrate
```

And some tests:

```
$ rails test
Running via Spring preloader in process 57084
Run options: --seed 26227

# Running:

.

Finished in 0.439060s, 2.2776 runs/s, 2.2776 assertions/s.
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

### Step 2: Adding Docker Support

Adding:

* [Dockerfile](./minime/Dockerfile)
* [docker-compose.yml](./minime/docker-compose.yml)
* [.dockerignore](./minime/.dockerignore) to prevent locally installed assets from being added to the image
* [entrypoint.sh](./minime/entrypoint.sh) provides a default Rails application startup for the

```
$ docker-compose build
$ docker-compose run --rm web bundle exec rails db:create
$ docker-compose run --rm web bundle exec rails db:migrate
$ docker-compose up
```

Or to daemonize:

```
$ docker-compose up
```

And it is running OK on `http://0.0.0.0:3000` ..

![web_initial_dockerized](./assets/web_initial_dockerized.png?raw=true)

Run a shell:

```
docker-compose run --rm web bash
```

Run tests in docker:

```
$ docker-compose run --rm web bundle exec rails test
Starting minime_db_1 ... done
Running via Spring preloader in process 15
Run options: --seed 19759

# Running:

.

Finished in 9.117707s, 0.1097 runs/s, 0.1097 assertions/s.
1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

```

### Rails-specific Refinements

#### Sharing the File System

For development, it can be useful to share the file system, so that editing locally can be immediately
picked up by the container.

However, care is required with folders that may contain platform-specific versions.
This is specifically an issue with `node_modules`.

The following volume mapping in the `docker-compose.yml` shares the application files
but excludes `node_modules`.

```
web:
  volumes:
    - .:/app
    - /app/node_modules/
```

If file sharing is not required, this volumes section can be removed (speeds things up).

Testing the shared file system by running [localhost:3000/articles](http://localhost:3000/articles) from docker
and modifying the view file on the local file system:

![articles_mod](./assets/articles_mod.png?raw=true)


#### Environment-driven Database Configuration

Updating the `config/database.yml` to ensure that the database configuration
can be completely driven from the environment (and the `docker-compose.yml` file).

```
default: &default
  adapter: postgresql
  encoding: unicode
  host: <%= ENV['RAILS_DB_HOST'] %>
  username: <%= ENV['RAILS_DB_USERNAME'] %>
  password: <%= ENV['RAILS_DB_PASSWORD'] %>
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  database: <%= ENV['RAILS_DB_NAME'] || "minime_#{ENV['RAILS_ENV'] || 'development'}" %>
```

NB: alternatively, use the standard `DATABASE_URL` environment settings, as [described in the Rails guides](https://guides.rubyonrails.org/configuring.html#configuring-a-database).

## Credits and References

* [Rails on Docker: Using Docker Compose with Your Ruby on Rails Apps](https://www.chrisblunt.com/rails-on-docker-using-docker-compose-with-your-ruby-on-rails-apps/)
* [Dockerize and Deploy to AWS EC2](https://medium.com/@matayoshi.mariano/dockerize-and-deploy-to-aws-ec2-9208068fb92b)
* [Create new Rails 6 project with Docker](https://dev.to/rogiervandenberg/create-new-rails-6-project-with-docker-56io)
* [Setting up Rails 6 with PostgreSQL & Webpack on Docker](https://medium.com/@guillaumeocculy/setting-up-rails-6-with-postgresql-webpack-on-docker-a51c1044f0e4)
* [docker-compose-rails-6](https://github.com/DiveIntoHacking/docker-compose-rails-6) - example repository defines docker files(Dockerfile and docker-compose.yml) to create the image
* [How to use Bundler with Docker](https://bundler.io/guides/bundler_docker_guide.html)
* [Quickstart: Compose and Rails](https://docs.docker.com/compose/rails/)
* [Add a volume to Docker, but exclude a sub-folder](https://stackoverflow.com/questions/29181032/add-a-volume-to-docker-but-exclude-a-sub-folder) - stackoverflow
