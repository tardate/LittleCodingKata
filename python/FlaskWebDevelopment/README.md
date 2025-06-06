# #259 Flask Web Development

Book notes - Flask Web Development, By Miguel Grinberg, published by O'Reilly.

## Notes

## Table of Contents - Highlights

### Part I. Introduction to Flask

#### 1. Installation

* Using Virtual Environments
* Installing Python Packages with pip

#### 2. Basic Application Structure

* Initialization
* Routes and View Functions
* Server Startup
* A Complete Application
* The Request-Response Cycle
    * Application and Request Contexts
    * Request Dispatching
    * Request Hooks
    * Responses
* Flask Extensions
    * Command-Line Options with Flask-Script

#### 3. Templates

* The Jinja2 Template Engine
    * Rendering Templates
    * Variables
    * Control Structures
* Twitter Bootstrap Integration with Flask-Bootstrap
* Custom Error Pages
* Links
* Static Files
* Localization of Dates and Times with Flask-Moment

#### 4. Web Forms

* Cross-Site Request Forgery (CSRF) Protection
* Form Classes
* HTML Rendering of Forms
* Form Handling in View Functions
* Redirects and User Sessions
* Message Flashing

#### 5. Databases

* SQL Databases
* NoSQL Databases
* SQL or NoSQL?
* Python Database Frameworks
* Database Management with Flask-SQLAlchemy
* Model Definition
* Relationships
* Database Operations
    * Creating the Tables
    * Inserting Rows
    * Modifying Rows
    * Deleting Rows
    * Querying Rows
* Database Use in View Functions
* Integration with the Python Shell
* Database Migrations with Flask-Migrate
    * Creating a Migration Repository
    * Creating a Migration Script
    * Upgrading the Database

#### 6. Email

* Email Support with Flask-Mail
    * Sending Email from the Python Shell
    * Integrating Emails with the Application
    * Sending Asynchronous Email

#### 7. Large Application Structure

* Project Structure
* Configuration Options
* Application Package 78
    * Using an Application Factory
    * Implementing Application Functionality in a Blueprint
* Launch Script
* Requirements File
* Unit Tests
* Database Setup

### Part II. Example: A Social Blogging Application

#### 8. User Authentication

* Authentication Extensions for Flask
* Password Security
    * Hashing Passwords with Werkzeug
* Creating an Authentication Blueprint
* User Authentication with Flask-Login
    * Preparing the User Model for Logins
    * Protecting Routes
    * Adding a Login Form
    * Signing Users In
    * Signing Users Out
    * Testing Logins
* New User Registration
    * Adding a User Registration Form
    * Registering New Users
* Account Confirmation
    * Generating Confirmation Tokens with itsdangerous
    * Sending Confirmation Emails
* Account Management

#### 9. User Roles

* Database Representation of Roles
* Role Assignment
* Role Verification

#### 10. User Profiles

* Profile Information
* User Profile Page
* Profile Editor
    * User-Level Profile Editor
    * Administrator-Level Profile Editor
* User Avatars

#### 11. Blog Posts

* Blog Post Submission and Display
* Blog Posts on Profile Pages
* Paginating Long Blog Post Lists
    * Creating Fake Blog Post Data
    * Rendering Data on Pages
    * Adding a Pagination Widget
* Rich-Text Posts with Markdown and Flask-PageDown
    * Using Flask-PageDown
    * Handling Rich Text on the Server
* Permanent Links to Blog Posts
* Blog Post Editor

#### 12. Followers

* Database Relationships Revisited
    * Many-to-Many Relationships
    * Self-Referential Relationships
    * Advanced Many-to-Many Relationships
* Followers on the Profile Page
* Query Followed Posts Using a Database Join
* Show Followed Posts on the Home Page

#### 13. User Comments

* Database Representation of Comments
* Comment Submission and Display
* Comment Moderation

#### 14. Application Programming Interfaces

* Introduction to REST
    * Resources Are Everything
    * Request Methods
    * Request and Response Bodies
    * Versioning
* RESTful Web Services with Flask
    * Creating an API Blueprint
    * Error Handling
    * User Authentication with Flask-HTTPAuth
    * Token-Based Authentication
    * Serializing Resources to and from JSON
    * Implementing Resource Endpoints
    * Pagination of Large Resource Collections
    * Testing Web Services with HTTPie

### Part III. The Last Mile

#### 15. Testing

* Obtaining Code Coverage Reports
* The Flask Test Client
    * Testing Web Applications
    * Testing Web Services
* End-to-End Testing with Selenium
* Is It Worth It?

#### 16. Performance

* Logging Slow Database Performance
* Source Code Profiling

#### 17. Deployment

* Deployment Workflow
* Logging of Errors During Production
* Cloud Deployment
* The Heroku Platform
    * Preparing the Application
    * Testing with Foreman
    * Enabling Secure HTTP with Flask-SSLify
    * Deploying with git push
    * Reviewing Logs
    * Deploying an Upgrade
* Traditional Hosting
    * Server Setup
    * Importing Environment Variables
    * Setting Up Logging 2

#### 18. Additional Resources

* Using an Integrated Development Environment (IDE)
* Finding Flask Extensions
    * Flask-Babel: Internationalization and localization support
    * Flask-RESTful: Tools for building RESTful APIs
    * Celery: Task queue for processing background jobs
    * Frozen-Flask: Conversion of a Flask application to a static website
    * Flask-DebugToolbar: In-browser debugging tools
    * Flask-Assets: Merging, minifying, and compiling of CSS and JavaScript assets
    * Flask-OAuth: Authentication against OAuth providers
    * Flask-OpenID: Authentication against OpenID providers
    * Flask-WhooshAlchemy: Full-text search for Flask-SQLAlchemy models based on Whoosh
    * Flask-KVsession: Alternative implementation of user sessions that use server-side storage
* Getting Involved with Flask

## Getting the Example Source

```sh
git clone https://github.com/miguelgrinberg/flasky.git example_source
```

## Credits and References

* [Flask Book](https://flaskbook.com/) - Companion site for the Flask book and training videos by Miguel Grinberg
* [Flask Web Development](https://learning.oreilly.com/library/view/flask-web-development/9781491947586/)
* [Errata for Flask Web Development](https://www.oreilly.com/catalog/errata.csp?isbn=9781449372620)
* [Flask Web Development Example](https://github.com/miguelgrinberg/flasky) - github
* [Flask documentation](https://flask.palletsprojects.com/)
