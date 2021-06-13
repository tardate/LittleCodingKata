# Rails 6 with Docker for Production

All about running Rails 6 with Docker for production deployment

## Notes

Exploring and demonstrating Docker-related Rails configuration topics that are specific to designing and deploying
high performance, fault-tolerant applications for production.

#### Checking Pre-requisites and Installation

Here's the MacOSX host environment I'm using to build and run the examples
```
$ node -v
v12.8.0
$ npm -v
6.10.2
$ ruby -v
ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-darwin17]
$ gem install rails -v 6.1.3.2
...
$ rails --version
Rails 6.1.3.2
$ docker --version
Docker version 19.03.13, build 4484c46d9d

```

## Designing the Example Rails App

As an example, I've chosen a simple application that includes all the features that are worth exploring and demonstrating from a production deployment perspective:

* a "company directory" application:
  * has many companies
  * each company has an address that is geocoded
  * each company has many staff
* as a user I can register myself with a staff profile and company affiliation
  * I can upload a profile picture that will be displayed in the staff list
* user registration emails are handled in the background
* address geocoding is handled in the background
* company directory pages can take advantage if application fragment caching


The infrastruture components:

* rails application docker image that includes two services:
  * the main app: running the HTTP(S) site
  * background job workers
* PostgreSQL Database
* Devise for authentication
* Redis - for caching and sidekiq
* Sidekiq for backgorund jobs
* AWS S3 for custom asset storage


## Architectural Considerations for Production

### Rails Secrets

[Encrypted secrets](https://guides.rubyonrails.org/5_1_release_notes.html#encrypted-secrets) were introduced in Rails 5.1.
This is a simple, standardised approach for giving a Rails application encrypted secrets at runtime.
Typically it would be used by:

* committing the encrypted secrets file `config/credentials.yml.enc` in the repo
* distributing the `config/master.key` separately

This is fine for Rails apps that are built and deployed by the same Rails team.
However this is not a great or even feasible approach for applications that are shipped for other teams to operate.

I think for Rails apps that are distributed as Docker images, expectations are usually:
* perhaps many other teams may run/operate the app from the image
* those teams do not/cannot share secrets between themselves
* and do not necessarily have any Rails expertise (e.g. to create their own encrypted secrets files)

In these cases, I think it is best to avoid Rails encrypted secrets, and any secrets required by the application:

* are preferrably configured via the application admin UI after startup
* are provided via the environment if absolutely needed at startup. The docker operations team is responsible for securing the environment.

In this example application, I have chosen to disable Rails encrypted secrets (actually deleted the files). All settings required at startup come from the environment.
Also, ensure `config.require_master_key = false` is set for production.

### Application Deployment Components: Running the App and Workers

Ideally we want the flexibility to run the docker image in a number of modes:

* web app and background workers in a single container (ideal for testing or very small loads)
* web app only - mulitple instances that can be load balanced
* background workers - mulitple instances that can be horizontally scaled


### How to Serve Rails Assets

Two basic questions:

When to compile? Options:

* at Docker build
* at startup

How to Serve? Options:

* direct from Rails application
* from CDN


RAILS_SERVE_STATIC_FILES

### Container Orchestration

### Logging

RAILS_LOG_TO_STDOUT


## Building the Example Rails App

Where all Rails apps start:

```
rails new stafflist --database=postgresql
```

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

Rails Encrypted Secrets are also disabled - we won't use this feature:

* delete `config/credentials.yml.enc`
* delete `config/master.key`
* in `config/environments/production`: set `config.require_master_key = false`


#### Basic App Scaffold

```
$ rails db:create
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
Created database 'stafflist_development'
Created database 'stafflist_test'
```

NB: get rid of the tzinfo-data platform warning with `bundle config --local disable_platform_warnings true`


Adding core features (including tests)

```
rails generate scaffold company name:string street_address:string postcode:string country_name:string
rails generate scaffold user email:uniq password:digest name:string company_id:integer
rails db:migrate
```

Tests are ok:

```
$ rails test
Running via Spring preloader in process 42534
Run options: --seed 61039

# Running:

..............

Finished in 1.216182s, 11.5114 runs/s, 14.8004 assertions/s.
14 runs, 18 assertions, 0 failures, 0 errors, 0 skips

```


### Adding Docker Support

Adding:

* [Dockerfile](./stafflist/docker/Dockerfile)
* [entrypoint.sh](./stafflist/docker/entrypoint.sh) provides default Rails application startup
* [docker-compose.yml](./stafflist/docker-compose.yml)
* [.dockerignore](./stafflist/.dockerignore) to prevent locally installed assets from being added to the image

```
$ docker-compose build
$ docker-compose run --rm app bundle exec rails db:create
$ docker-compose run --rm app bundle exec rails db:migrate
$ docker-compose up
...
db_1     | 2021-06-13 10:21:37.640 UTC [1] LOG:  database system is ready to accept connections
app_1    | => Booting Puma
app_1    | => Rails 6.1.3.2 application starting in development
app_1    | => Run `bin/rails server --help` for more startup options
app_1    | Puma starting in single mode...
app_1    | * Puma version: 5.3.2 (ruby 2.7.2-p137) ("Sweetnighter")
app_1    | *  Min threads: 5
app_1    | *  Max threads: 5
app_1    | *  Environment: development
app_1    | *          PID: 1
app_1    | * Listening on http://0.0.0.0:3000
...
```


docker-compose run --rm app bundle exec rails test


### Running in production

Set `RAILS_ENV=production` pass to the containers. Per request or export one-time.

$ RAILS_ENV=production docker-compose run --rm app bundle exec rails db:create
$ RAILS_ENV=production docker-compose run --rm app bundle exec rails db:migrate
$ RAILS_ENV=production docker-compose up
...
app_1    | => Booting Puma
app_1    | => Rails 6.1.3.2 application starting in production
app_1    | => Run `bin/rails server --help` for more startup options
app_1    | Puma starting in single mode...
app_1    | * Puma version: 5.3.2 (ruby 2.7.2-p137) ("Sweetnighter")
app_1    | *  Min threads: 5
app_1    | *  Max threads: 5
app_1    | *  Environment: production
app_1    | *          PID: 1
app_1    | * Listening on http://0.0.0.0:3000
...

### Environment Variables

| variable | default | notes|
|----------|---------|------|
| RAILS_ENV  | development | development, test, or production |
| RAILS_DB_HOST     | localhost | database host |
| RAILS_DB_USERNAME | n/a | database username |
| RAILS_DB_PASSWORD | n/a | database password |
| RAILS_DB_POOL | 5 | db connection pool size. Generally, same as RAILS_MAX_THREADS |
| RAILS_DB_NAME     | "stafflist_#{ENV['RAILS_ENV']}" | set the database name |
| REDIS_URL | "redis://localhost:6379/1" | redis |
| RAILS_MAX_THREADS | 5 | puma threads |
| RAILS_MIN_THREADS | 5 | puma threads |
| PORT | 3000 | Specifies the port that Puma will use |
| PIDFILE| "tmp/pids/server.pid"  |  Specifies the `pidfile` that Puma will use. |
| SECRET_KEY_BASE |
| RAILS_SERVE_STATIC_FILES
| RAILS_LOG_TO_STDOUT



## adding sidekiq

https://stackoverflow.com/questions/63405314/dockercompose-build-one-image-and-run-multiple-containers


wip ... more to come

## Credits and References

* [Docker for Rails Developers](https://pragprog.com/titles/ridocker/docker-for-rails-developers/)
* [Deploying Rails 6 Assets with Docker and Kubernetes](https://blog.cloud66.com/deploying-rails-6-assets-with-docker/)
* [How to disable credentials and use secrets in Rails 5.2 RC2](https://github.com/rails/rails/issues/32413)
* [Encrypted Secrets(Credentials) in Rails 6, Rails 5.1/5.2, older versions and non-Rails applications](https://kirillshevch.medium.com/encrypted-secrets-credentials-in-rails-6-rails-5-1-5-2-f470accd62fc)
* [Environment variables in Docker Compose](https://docs.docker.com/compose/environment-variables/)
