# #098 AntiPatterns

Book notes - Rails AntiPatterns by Chad Pytel and Tammer Saleh, published by Addison-Wesley Professional.

## Notes

I devoured [Rails AntiPatterns](https://learning.oreilly.com/library/view/railstm-antipatterns-best/9780321620293/)
back in the day (it was published in 2010), and the advice it offers has stood the test of time.


### Table of Contents - Highlights

#### 1. Models

voyeristic models

* problem: models know too much about the entire system
* solution: law of demeter
* - principle of least knowledge
* - not make indirect calls
* - use only one dot
* solution: push all find() calls into finders on the model
* solution: keep finders on their own model

fat models

* problem: many methods in a single model class
* solution: delegate responsibility to new classes
* solution: use modules
* solution: reduce the size of large transaction blocks

spaghetti SQL

* problem: using SQL instead of AR capabilities
* solution: use AR associations and finders effectively
* solution: learn and love the scope method
* solution: use full-text search
* - ferret, sphinx, solr, xapian

duplicate code duplication

* problem:models not DRY
* solution: extract into modules
* solution: write a plugin/gem
* solution: meta-programming

#### 2. Domain Modeling

authorization astronaut

* problem: authorization nuilt into user model helper methods
* solution: simplify with simple flags (roles has flags)

million model march

* problem: model bloat
* solution: denormalise into text fields
* solution: use rails serialization

#### 3. Views

PHPitis

* problem: too much code in the view template
* solution: use standard helpers
* solution: add useful accessors to your models
* solution: extract to custom helpers
* - can also use a decorator (*)

markup mayhem

* problem: non-semantic markup
* solution: use rails helpers
* solution: use haml

#### 4. Controllers

homemade keys

* problem: custom authentication schemes
* solution: use clearance/device/authlogic...

fat controller

* problem: business logic in the controller
* solution: use AR callbacks and setters
* solution: move to presenter
* - plain ruby class that orchestrates creation of multiple models

bloated sessions

* problem: too much data in cookies/session store
* solution: store references instead of instances

monolithic controllers

* problem: many non-RESTful actions
* solution: embrace REST

controller with many faces

* problem: controller takes on some non-RESTful responsibilities
* solution: refactor non-RESTful actions into another controller

lost child controller

* problem: child model instances created without parent
* solution: use nested resources

rats nest resources

* problem: controllers that work as both nested and not
* solution: use separate controllers for each nesting
* - or IR optional parents

evil twin controllers

* problem: not DRY across different controllers that work on same model
* solution: use rails 3 responders

#### 5. Services

fire and forget

* problem: make external call and ignore the response
* solution: know what exceptions to look out for

sluggish services

* problem: external apps too slow
* solution: set your timeouts
* solution: move task to background

pitiful page parsing

* problem: web scraping
* solution: use a gem e.g.
* - nokogiri
* - rest_client

successful failure

* problem: errors sent back as HTTP 200 response
* solution: obey HTTP status codes

kraken code base

* problem: code base growing very large
* solution: divide into confederated applications

#### 6. Using Third-party Code

Recutting the gem

* problem: repeated requirements across many projects
* solution: look for a gem first

amateur gemologist

* problem: can't assume an existing gem is suitable
* solution: follow TAM
* - check for tests
* - check for activity
* - check for maturity

vendor junk drawer

* problem: fail to keep the number of gems manageable
* solution: prune irrelevant or unused gems

miscreant modification

* problem: gem has bugs or needs extension
* solution: consider vendored code sacrosanct
* - monkey patch
* - fork
* - share and share-alike


#### 7. Testing

Fixture blues

* problem: fixtures are fragile, imported to db without validation, skip AR lifecycle
* solution: make use of factories
* solution: refactor into contexts

lost in isolation

* problem: mocking obscures actual behaviour
* solution: watch your integration points
* - ensure integraiton tests cover unit tests that use mocks

mock suffocation

* problem:
* solution:

untested rake

* problem: rake tasks not tested
* solution: extract to class method

unprotected jewels

* problem: extracting to gem/plugin need tests too
* solution: write normal unit tests without rails
* solution: load only the parts of rails you need
* solution: break out the atom bomb (include ful rails in your tests)

#### 8. Scaling & Deploying

scaling roadblocks

* problem: initial work is scale limited
* solution: build to scale from the start
* - head in the clouds (e.g. paperclip can support S3)
* - file system limits
* - deploy to clustered env from start (e.g. heroku)

disappearing assets

* problem: fixed assets must not be moved during deployment (e.g. with capistrano)
* solution: make use of system directory (capistrano provided)

sluggish SQL

* problem: sql performance issues
* solution: add indexes
* solution: reassess your domain model

painful performance

* problem: slow response
* solution: don't do in ruby what you can do in SQL
* solution: move processing into background jobs
* solution:

#### 9. Databases

messy migrations

* problem: over time become a tangle of code
* solution: never modify the up method of a committed migration
* solution: never use external code in a migration
* solution: always provide a down method (and run up/down to verify)

wet validations

* problem: db attempts to enforce rails validations
* solution: eschew constraints in the db (exceptions e.g. boolean)

#### 10. Building for Failure

continual catastrophe

* problem: lurking failure modes
* solution: fail fast

inaudible failures

* problem: failures don't bubble or report
* solution: never fail quietly
* - embrace the !
* - never rescue nil
* - log to a useful place (e.g. airbrake)


## Credits and References

* [Rails™ AntiPatterns: Best Practice Ruby on Rails™ Refactoring](https://learning.oreilly.com/library/view/railstm-antipatterns-best/9780321620293/)
* [Rails AntiPatterns](https://www.goodreads.com/book/show/7933151-rails-antipatterns) - goodreads
