# #258 Lightweight Django

Book notes - Lightweight Django, By Julia Elman, Mark Lavin, published by O'Reilly.

## Notes

## Table of Contents - Highlights

### 1. The World’s Smallest Django Project

* Hello Django
    * Creating the View
    * The URL Patterns
    * The Settings
    * Running the Example
* Improvements
    * WSGI Application
    * Additional Configuration
    * Reusable Template

### 2. Stateless Web Application

* Why Stateless?
* Reusable Apps Versus Composable Services
* Placeholder Image Server
    * Views
    * URL Patterns
* Placeholder View
    * Image Manipulation
    * Adding Caching
* Creating the Home Page View
    * Adding Static and Template Settings
    * Home Page Template and CSS
    * Completed Project

### 3. Building a Static Site Generator

* Creating Static Sites with Django
* What Is Rapid Prototyping?
* Initial Project Layout
    * File/Folder Scaffolding
    * Basic Settings
* Page Rendering
    * Creating Our Base Templates
    * Static Page Generator
    * Basic Styling
    * Prototype Layouts and Navigation
* Generating Static Content
    * Settings Configuration
    * Custom Management Command
    * Building a Single Page
* Serving and Compressing Static Files
    * Hashing Our CSS and JavaScript Files
    * Compressing Our Static Files
* Generating Dynamic Content
    * Updating Our Templates
    * Adding Metadata

### 4. Building a REST API

* Django and REST
* Scrum Board Data Map
    * Initial Project Layout
    * Project Settings
    * No Django Admin?
    * Models
* Designing the API
    * Sprint Endpoints
    * Task and User Endpoints
    * Connecting to the Router
    * Linking Resources
* Testing Out the API
    * Using the Browsable API
    * Adding Filtering
    * Adding Validations
    * Using a Python Client
* Next Steps

### 5. Client-Side Django with Backbone.js

* Brief Overview of Backbone
* Setting Up Your Project Files
    * JavaScript Dependencies
    * Organization of Your Backbone Application Files
* Connecting Backbone to Django
* Client-Side Backbone Routing
    * Creating a Basic Home Page View
    * Setting Up a Minimal Router
    * Using _.template from Underscore.js
* Building User Authentication
    * Creating a Session Model
    * Creating a Login View
    * Generic Form View
    * Authenticating Routes
    * Creating a Header View

### 6. Single-Page Web Application

* What Are Single-Page Web Applications?
* Discovering the API
    * Fetching the API
    * Model Customizations
    * Collection Customizations
* Building Our Home Page
* Displaying the Current Sprints
* Creating New Sprints
* Sprint Detail Page
    * Rendering the Sprint
    * Routing the Sprint Detail
    * Using the Client State
    * Rendering the Tasks
    * AddTaskView
* CRUD Tasks
    * Rendering Tasks Within a Sprint
    * Updating Tasks
    * Inline Edit Features

### 7. Real-Time Django

* HTML5 Real-Time APIs
    * Websockets
    * Server-Sent Events
    * WebRTC
* Websockets with Tornado
    * Introduction to Tornado
    * Message Subscriptions
* Client Communication
    * Minimal Example
    * Socket Wrapper
    * Client Connection
    * Sending Events from the Client
    * Handling Events from the Client
    * Updating Task State

### 8. Communication Between Django and Tornado

* Receiving Updates in Tornado
    * Sending Updates from Django
    * Handling Updates on the Client
* Server Improvements
    * Robust Subscriptions
    * Websocket Authentication
    * Better Updates
    * Secure Updates
* Final Websocket Server

## Getting the Example Source

```sh
git clone https://github.com/lightweightdjango/examples.git example_source
```

## Credits and References

* [Lightweight Django](https://learning.oreilly.com/library/view/lightweight-django/9781491946275/)
* [Errata for Lightweight Django](https://www.oreilly.com/catalog/errata.csp?isbn=9781491945940)
* [Lightweight Django Examples](https://github.com/lightweightdjango/examples) - github
* [Talk Python #88: Lightweight Django](https://www.youtube.com/watch?v=786AE_scHww) - YouTube
* [Talk Python #88: Lightweight Django](https://talkpython.fm/88) - links
