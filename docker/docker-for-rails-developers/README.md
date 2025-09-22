# #153 Docker for Rails Developers

Notes on the book Docker for Rails Developers, By Rob Isenberg, published by The Pragmatic Programmers

## Notes

See:

* [Pragmatic Programmers listing](https://pragprog.com/titles/ridocker/docker-for-rails-developers/)
* [goodreads](https://www.goodreads.com/book/show/39815976-docker-for-rails-developers)

## Highlights from the Table of Contents

### Part I — Development

#### 1. A Brave New World

* Installing Docker
* Verifying Your Install
* Before We Begin
* Running a Ruby Script Without Ruby Installed
* Generating a New Rails App Without Ruby Installed

#### 2. Running a Rails App in a Container

* How Do We Run Our Rails App?
* Defining Our First Custom Image
* Building Our Image
* Running a Rails Server with Our Image
* Reaching the App: Publishing Ports
* Binding the Rails Server to IP Addresses

#### 3. Fine-Tuning Our Rails Image

* Naming and Versioning Our Image
* A Default Command
* Ignoring Unnecessary Files
* The Image Build Cache
* Caching Issue 1: Updating Packages
* Caching Issue 2: Unnecessary Gem Installs
* The Finishing Touch

#### 4. Describing Our App Declaratively with Docker Compose

* Getting Started with Compose
* Launching Our App
* Mounting a Local Volume
* Starting and Stopping Services
* Other Common Tasks

#### 5. Beyond the App: Adding Redis

* Starting a Redis Server
* Manually Connecting to the Redis Server
* How Containers Can Talk to Each Other
* Our Rails App Talking to Redis
* Starting the Entire App with Docker Compose

#### 6. Adding a Database: Postgres

* Starting a Postgres Server
* Connecting to Postgres from a Separate Container
* Connecting Our Rails App to Postgres
* Using the Database in Practice
* Decoupling Data from the Container

#### 7. Playing Nice with JavaScript

* The JavaScript Front-End Options
* Rails JavaScript Front End with Webpacker
* Compiling Assets with Webpacker
* A Hello World React App

#### 8. Testing in a Dockerized Environment

* Setting Up RSpec
* Our First Test
* Setting Up Rails System Tests
* Running Tests That Rely on JavaScript
* Debugging

#### 9. Advanced Gem Management

* The Downside to Our Existing Approach
* Using a Gem Cache Volume

#### 10. Some Minor Irritations

* Rails tmp/pids/server.pid Not Cleaned Up
* Compose Intermittently Aborts with Ctrl-C

### Part II — Toward Production

#### 11. The Production Landscape

* The "Ops" in DevOps
* Container Orchestration
* A Tale of Two Orchestrators: Swarm and Kubernetes
* IaaS vs. CaaS
* Provisioning Your Infrastructure
* CaaS Platforms
* Serverless for Containers
* How to Decide What’s Right for Me?

#### 12. Preparing for Production

* Configuring a Production Environment
* A Production Image: Precompiling Assets
* Sharing Images

#### 13. A Production-Like Playground

* Creating Machines
* Introducing Docker Swarm
* Our First (Single Node) Swarm
* Describing Our App to Swarm
* Migrating the Database
* Deploying Our App on a Swarm
* Tasks and Swarm’s Scaling Model
* Scaling Up the Service

#### 14. Deploying to the Cloud

* Creating a DigitalOcean Cluster
* Deploying to Our DigitalOcean Swarm
* Visualizing Containers
* Scale Up the Web Service
* Deploying to AWS Instead of DigitalOcean

## Getting the Examples Source

```sh
wget http://media.pragprog.com/titles/ridocker/code/ridocker-code.zip
tar zxvf ridocker-code.zip
rm ridocker-code.zip
```

unzips into a `code` folder.

## Credits and References

* [Pragmatic Programmers listing](https://pragprog.com/titles/ridocker/docker-for-rails-developers/)
* [goodreads](https://www.goodreads.com/book/show/39815976-docker-for-rails-developers)
* [examples source (zip)](http://media.pragprog.com/titles/ridocker/code/ridocker-code.zip)
