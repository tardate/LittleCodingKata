# RailsConf 2024

Overview and notes from RailsConf 2024, May 7 – 9, 2024.

## Links

* [RailsConf 2024 playlist](https://www.youtube.com/playlist?list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh#railsconf2024)
* [railsconf.org](https://railsconf.org/)

## Talks

### [RailsConf 2024 - Opening Conference Keynote by Nadia Odunayo](https://www.youtube.com/watch?v=TWi-cSHNr5s&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=3)

Nadia Odunayo
Founder & CEO @ The StoryGraph

* keep the tech simple
* keep talking to customers
    * .. properly
    * no demo
    * open ended questions
* keep costs low / under control

### [How to Accessibility if You’re Mostly Back-End by Hilary Stohs-Krause](https://www.youtube.com/watch?v=GyUxe7PMD4A&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=3)

Hilary Stohs-Krause
Senior Software Engineer at Red Canary

If you work mostly on the back-end of the tech stack, it’s easy to assume that your role is disengaged from accessibility concerns. After all, that’s the front-end’s job! However, there are multiple, specific ways back-end devs can impact accessibility - not just for users, but also for colleagues.

> we make products accessible, but not the processes by which they are built. Our development practices themselves are inaccessible.

avoid abbreviations
readability

### [So writing tests feels painful. What now? by Stephanie Minn](https://www.youtube.com/watch?v=VmWCJFiU1oM&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=4)

Stephanie Minn
Developer at thoughtbot

When you write tests, you are interacting with your code. Like any user experience, you may encounter friction. Stubbing endless methods to get to green. Fixing unrelated spec files after a minor change. Rather than push on, let this tedium guide you toward better software design.

With examples in RSpec, this talk will take you step-by-step from a troublesome test to an informed refactor. Join me in learning how to attune to the right signals and manage complexity familiar to any Rails developer. You’ll leave with newfound inspiration to write clear, maintainable tests in peace. Your future self will thank you!

### [Ask your logs by Youssef Boulkaid](https://www.youtube.com/watch?v=y-VMajyrQnU&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=5)

Youssef Boulkaid
Senior developer @ Workato

Logging is often an afterthought when we put our apps in production. It's there, it's configured by default and it's... good enough?

If you have ever tried to debug a production issue by digging in your application logs, you know that it is a challenge to find the information you need in the gigabyte-sized haystack that is the default rails log output.

In this talk, let's explore how we can use structured logging to turn our logs into data and use dedicated tools to ask — and answer — some non-obvious questions of our logs.

### [How to make your application accessible (and keep it that way!) by Joel Hawksley]<https://www.youtube.com/watch?v=ZRUn-yRH0ks&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=6>

Joel Hawksley
Staff Engineer at GitHub

Our industry is shockingly bad at accessibility: by some estimates, over 70% of websites are effectively unavailable to blind users! Making your app accessible isn’t just the right thing to do, it’s the law. In this talk, we’ll share what it’s taken to scale GitHub’s accessibility program and equip you to do the same at your company.

### [Ruby on Fails: effective error handling with... by Talysson Oliveira Cassiano](https://www.youtube.com/watch?v=qFZb9fMz8bs&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=7)

Talysson Oliveira Cassiano
Webdeveloper @ Codeminer42

You ask 10 different developers how they handle errors in their applications, you get 10 very different answers or more, that’s wild. From never raising errors to using custom errors, rescue_from, result objects, monads, we see all sorts of opinions out there. Is it possible that all of them are right? Maybe none of them? Do they take advantage of Rails conventions? In this talk, I will show you error-handling approaches based on patterns we see on typical everyday Rails applications, what their tradeoffs are, and which of them are safe defaults to use as a primary choice when defining the architecture of your application

### [Look Ma, No Background Jobs: A Peek into the Async Future by Manu J](https://www.youtube.com/watch?v=QeYcKw7nOkg&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=8)

Manu J
Engineering Lead @ Lodgistics. Creator of ZestUI

Executing a long running task like external API requests in the request-response cycle is guaranteed to bring your Rails app to its knees sooner or later. We have relied on background jobs to offload long running tasks due to this.

But it doesn't always have to be. Learn how you can leverage Falcon and the Async gem to unlock the full potential of ruby fibers and eliminate background jobs for IO-bound tasks and execute them directly with clean, simple, performant and scalable code.

### [Ruby & Rails Versioning at Scale by George Ma](https://www.youtube.com/watch?v=XBdsKmxS2lw&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=9)

George Ma
Developer, Rails Infrastructure at Shopify

In this talk we will dive into how Shopify automated Rails upgrades as well as leveraged Dependabot, Rubocop, and Bundler to easily upgrade and maintain 300+ Ruby Services at Shopify to be on the latest Ruby & Rails versions. You'll learn how you can do the same!

### [What's in a Name: From Variables to Domain-Driven Design by Karynn Ikeda](https://www.youtube.com/watch?v=1flw60hwcLg&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=10)

Karynn Ikeda
Staff Engineer at Babylist

Join me on a crash course in semantic theory to unpack one of the hardest problems in software engineering: naming things. Dive into how names act as a linguistic front-end, masking a more complex backend of unseen associations. We’ll start from a single variable name and zoom out to the vantage point of domain-driven design, and track how consequential naming is at each stage to help you improve your code, no matter your level of experience.

### [Crafting Rails Plugins by Chris Oliver](https://www.youtube.com/watch?v=LxTCpTXhpzw&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=11)

Chris Oliver
Owner of GoRails

Ever wanted to build a plugin for Rails to add new features? Rails plugins allow you to hook into the lifecycle of a Rails application to add routes, configuration, migrations, models, controllers, views and more. In this talk, we'll learn how to do this by looking at some examples Rails gems to see how they work.

### [From Cryptic Error Messages To Rails Contributor by Collin Jilbert](https://www.youtube.com/watch?v=7EpJQn6ObEw&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=12)

Collin Jilbert
Ruby on Rails Developer at GoRails

Discover how encountering perplexing and misleading error messages in Ruby on Rails can lead to opportunities for contribution by delving into a real-world example. Join me as we dissect a perplexing Ruby on Rails error by navigating the source code. Discover how seemingly unrelated errors can be intertwined. As responsible community members, we'll explore turning this into an opportunity for contribution. Learn to navigate Rails, leverage Ruby fundamentals, and make impactful changes. From local experiments to contribution submission, empower yourself to enhance the experience of building with Rails for yourself and the community.

### [Plain, Old, but Mighty: Leveraging POROs in Greenfield and... by Sweta Sanghavi](https://www.youtube.com/watch?v=KQHD-0y8tDw&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=13)

Sweta Sanghavi
Tech Lead at BackerKit

Applications exist in changing ecosystems, but over time, they can become less responsive. Controllers actions slowly grow in responsibilities. Models designed for one requirement, no longer fit the bill, and require multi-step deploy processes to change.

The plain old Ruby object, the mighty PORO, provides flexibility in both new domain and legacy code.

Pair with me on how! We'll explore how we can leverage POROs in our application through some real world examples. We'll use objects as a facade for domain logic in development, and refactor objects out of legacy code to increase readability, ease of testing, and flexibility. You'll leave this session with some strategies to better leverage Ruby objects in your own application.

### [A Rails server in your editor: Using Ruby LSP to extract runtime... by Andy Waite](https://www.youtube.com/watch?v=oYTwUHAdH_A&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=14)

Andy Waite
Ruby Developer Experience team at Shopify

Language servers, like the Ruby LSP, typically use only static information about the code to provide editor features. But Ruby is a dynamic language and Rails makes extensive use of its meta-programming features. Can we get information from the runtime instead and use that to increase developer happiness?

In this talk, we’re going to explore how the Ruby LSP connects with the runtime of your Rails application to expose information about the database, migrations, routes and more. Join us for an in-depth exploration of Ruby LSP Rails, and learn how to extend it to support the Rails features most important to your app.

### [Implementing Native Composite Primary Key Support in Rails 7.1 by Nikita Vasilevsky](https://www.youtube.com/watch?v=Gm5Aiai368Y&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=15)

Nikita Vasilevsky
Developer in the Ruby and Rails Infrastructure team at Shopify

Explore the new feature of composite primary keys in Rails! Learn how to harness this powerful feature to optimize your applications, and gain insights into the scenarios where it can make a significant difference in database performance. Elevate your Rails expertise and stay ahead of the curve!

### [Riffing on Rails: sketch your way to better designed code by Kasper Timm Hansen](https://www.youtube.com/watch?v=vH-mNygyXs0&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=16)

Kasper Timm Hansen
Ruby consultant

Say you've been tasked with building a feature or subsystem in a Rails app. How do you get started? How do you plan out your objects? How do you figure out the names, responsibilities, and relationships? While some reach for pen & paper and others dive straight into implementation, there's a third option: Riffing on Rails.

When you riff, you work with Ruby code in a scratch file to help drive your design. This way you get rapid feedback and can revise as quickly as you had the idea — try out alternative implementations too! It's great for building shared understanding by pairing with a coworker.

Walk away with new ideas for improving your software making process: one where code is less daunting & precious. Riffing gives you space & grace to try more approaches & ideas. Let's riff!

### [Save Time with Custom Rails Generators by Garrett Dimon](https://www.youtube.com/watch?v=kKhzSge226g&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=17)

Garrett Dimon
Developer, Flipper Cloud

Become skilled at quickly creating well-tested custom generators and turn those tedious and repetitive ten-minute distractions into ten-second commands—not just for you but for your entire team. With some curated knowledge and insights about custom generators and some advanced warning about the speed bumps, it can save time in far more scenarios than you might think.

### [Keynote: Startups on Rails in 2024 by Irina Nazarova](https://www.youtube.com/watch?v=-sFYiyFQMU8&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=19)

Irina Nazarova
CEO @ Evil Martians

Let’s hear from startups that chose Rails in recent years. Would you be surprised to hear that Rails is quietly recommended founder to founder in the corridors of Y Combinator? But it’s not only the praise that is shared.

Rails is a 1-person framework, and the framework behind giants like Shopify. Airbnb, Twitter and Figma started on Rails back in the days, but those are stories of the past. As the new businesses switched to prioritizing productivity and pragmatism again, Rails 7 had stepped up its game with Hotwire. But is the startup community ready to renew the vows with Rails and commit to each other again? The answer is: Maybe!

Let’s use feedback from those founders to discuss how Rails has aided their growth and what improvements would help more founders start-up on Rails!

### [Day 2 Keynote by John Hawthorn](https://www.youtube.com/watch?v=WFtZjGT8Ih0&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=21)

John Hawthorn
Ruby Core, Rails Core, Staff @ Github

This talk introduces Vernier: a new sampling profiler for Ruby 3.2+ which is able to capture more details than existing tools including threads, ractors, the GVL, Garbage Collection, idle time, and more!

### [From slow to go: Rails test profiling hands-on by Vladimir Dementyev](https://www.youtube.com/watch?v=PvZw0CnZNPc&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=22)

Vladimir Dementyev
Principal Engineer at Evil Martians

Ever wished your Rails test suite to complete faster so you don’t waste your time procrastinating while waiting for the green light (or red, who knows—it’s still running)? Have you ever tried increasing the number of parallel workers on CI to solve the problem and reached the limit so there is no noticeable difference anymore?

If these questions catch your eye, come to my workshop on test profiling and learn how to identify and fix test performance bottlenecks in the most efficient way. And let your CI providers not complain about the lower bills afterward.

I will guide you through the test profiling upside-down pyramid, from trying to apply common Ruby profilers (Stackprof, Vernier) and learn from flamegrpahs to identifying test-specific performance issues via the TestProf toolbox.

### [TDD for Absolute Beginners by Jason Swett](https://www.youtube.com/watch?v=I5KnvTttfOM&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=23)

Jason Swett
Host of the Code with Jason Podcast

We're often taught that test-driven development is all about red-green-refactor. But WHY do we do it that way? And could it be that they way TDD is usually taught is actually misleading, and that there's a different and better way? In this workshop you'll discover a different, easier way to approach test-driven development.

### [SQLite on Rails: From rails new to 50k concurrent... by Stephen Margheim](https://www.youtube.com/watch?v=cPNeWdaJrL0&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=24)

Stephen Margheim
Rubyist, web developer, and engineering manager at Test IO

Learn how to build and deploy a Rails application using SQLite with hands-on exercises! Together we will take a brand new Rails application and walk through various features and enhancements to make a production-ready, full-featured application using only SQLite. We will take advantage of SQLite's lightweight database files to create separate databases for our data, job queue, cache, error monitoring, etc. We will install and use a SQLite extension to build vector similarity search. We will setup point-in-time backups with Litestream. We will also explore how to deploy your application. By the end of this workshop, you will understand what kinds of applications are a good fit for SQLite, how to build a resilient SQLite on Rails application, and how to scale to 50k+ concurrent users.

### [Let’s Extend Rails With A Gem by Noel Rappin](https://www.youtube.com/watch?v=eQvwn8p4HnE&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=25)

Noel Rappin
Staff Engineer at Chime Financial, co-author of Programming Ruby

Rails is powerful, but it doesn’t do everything. Sometimes you want to build your own tool that adds functionality to Rails. If it’s something that might be useful for other people, you can write a Ruby Gem and distribute it. In this workshop, we will go through the entire process of creating a gem, starting with “bundle gem” and ending with how to publish it with “gem push”. Along the way, we’ll show how to get started, how to manage configuration, how to be part of Rails configuration, whether you want to be a Rails Engine, and how to test against multiple versions of Rails. After this workshop, you will have all the tools you need to contribute your own gem to the Rails community.

### [Build High Performance Active Record Apps by Andrew Atkinson](https://www.youtube.com/watch?v=4SERkjBF-es&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=26)

Andrew Atkinson
Staff Software Engineer, Author

In this workshop, you'll learn to leverage powerful Active Record capabilities to bring your applications to the next level. We'll start from scratch and focus on two major areas. We’ll work with high performance queries and we’ll configure and use multiple databases.

You’ll learn how to write efficient queries with good visibility from your Active Record code. You’ll use a variety of index types to lower the cost and improve the performance of your queries. You'll use query planner info with Active Record.

Next we'll shift gears into multi-database application design. You'll introduce a second database instance, set up replication between them, and configure Active Record for writer and reader roles. With that in place, you’ll configure automatic role switching.

### [This or that? Similar methods & classes in Ruby && Rails by Andy Andrea](https://www.youtube.com/watch?v=tfxJyya6P6A&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=27)

Andy Andrea
Lead Software Developer at Panorama Education

Working with Ruby and Rails affords access to a wealth of convenience, power and productivity. It also gives us a bunch of similar but distinct ways for checking objects' equality, modeling datetimes, checking strings against regular expressions and accomplishing other common tasks. Sometimes, this leads to confusion; other times, we simply pick one option that works and might miss out something that handles a particular use case better.

In this talk, we'll take a look at groups of patterns, classes and methods often seen in Rails code that might seem similar or equivalent at first glance. We’ll see how they differ and look at any pros, cons or edge cases worth considering for each group so that we can make more informed decisions when writing our code.

### [Revisiting the Hotwire Landscape after Turbo 8 by Marco Roth](https://www.youtube.com/watch?v=eh2joX5n58o&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=28)

Marco Roth
Independent Consultant & Open Source Contributor

Hotwire has significantly altered the landscape of building interactive web applications with Ruby on Rails, marking a pivotal evolution toward seamless Full-Stack development.

With the release of Turbo 8, the ecosystem has gained new momentum, influencing how developers approach application design and interaction.

This session, led by Marco, a core maintainer of Stimulus, StimulusReflex, and CableReady, delves into capabilities introduced with Turbo 8, reevaluating its impact on the whole Rails and Hotwire ecosystem.

### [Undervalued: The Most Useful Design Pattern by Jared Norman](https://www.youtube.com/watch?v=4r6D0niRszw&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=29)

Jared Norman
Super Good Software

Value objects are one of the most useful but underused object-oriented software design patterns. Now that Ruby has first class support for them, let’s explore what we can do with them! Learn not just how and when to use value objects, but also how they can be used to bridge different domains, make your tests faster and more maintainable, and even make your code more performant. I’ll even show how to combine value objects with the factory pattern to create the most useful design pattern out there.

### [The Very Hungry Transaction by Daniel Colson](https://www.youtube.com/watch?v=L1gQL_nw73s&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=30)

Daniel Colson
Senior Software Engineer at GitHub

The story begins with a little database transaction. As the days go by, more and more business requirements cause the transaction to grow in size. We soon discover that it isn't a little transaction anymore, and it now poses a serious risk to our application and business. What went wrong, and how can we fix it?

In this talk we'll witness a database transaction gradually grow into a liability. We'll uncover some common but problematic patterns that can put our data integrity and database health at risk, and then offer strategies for fixing and preventing these patterns.

### [Insights Gained from Developing a Hybrid Application Using... by John Pollard](https://www.youtube.com/watch?v=fi9wytUSAYY&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=31)

John Pollard
VP of Software Development

In this session, we delve into the complexities and benefits of hybrid app development with Turbo-Native and Strada. We cover implementation intricacies, emphasizing strategic decisions and technical nuances. Key topics include crafting seamless mobile navigation and integrating native features for enhanced functionality. We also discuss the decision-making process for rendering pages, considering performance, user interaction, and feature complexity. Additionally, we explore creating usable native components that maintain app standards. Join us for practical insights learned from our hybrid app development journey.

### [Pairing with Intention: A Guide for Mentors by Alistair Norman](https://www.youtube.com/watch?v=aEqMNVbUzew&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=32)

Alistair Norman
Super Good Software Senior Developer

Learning as a new developer is difficult and sometimes overwhelming. As mentors, we’re tasked with teaching newer developers everything they need to know. Mentees can struggle to learn when presented with bigger picture concepts like design patterns, testing practices, and complicated application structures along with the details and basic syntax needed to write code all at once. We’ll explore how to be intentional with your pair programming to help your mentee with their desired learning outcomes while keeping them feeling engaged and empowered.

### [From Request To Response And Everything In Between by Kevin Lesht](https://www.youtube.com/watch?v=ExHNp0LGCVs&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=33)

Kevin Lesht
Senior Software Technical Lead at Home Chef

How does a web request make it through a Rails app? And, what happens when a lot of them are coming in, all at once? If you've ever been curious about how requests are handled, or about how to analyze and configure your infrastructure for optimally managing throughput, then this talk is for you!

In this session, you'll learn about the makeup of an individual web request, how Rails environments can best be setup to handle many requests at once, and how to keep your visitors happy along the way. We'll start by following a single request to its response, and scale all the way up through navigating high traffic scenarios.

### [Dungeons & Dragons & Rails by Joël Quenneville](https://www.youtube.com/watch?v=T7GdshXgQZE&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=34)

Joël Quenneville
Principal Developer at thoughtbot

You’ve found your way through the dungeon, charmed your way past that goblin checkpoint, and even slain a dragon. Now you face your biggest challenge yet - building a digital character sheet in Rails. Normally taking on an interactive beast like this requires a powerful spell like “react” but you’re all out of spell slots. Luckily you found an unlikely weapon in the dragon’s lair. They call it Turbo. Attune to your keyboards and roll for initiative! This task is no match for us!

### [Attraction Mailbox - Why I love Action Mailbox by Cody Norman](https://www.youtube.com/watch?v=i-RwxAVMP-k&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=35)

Cody Norman
Independent Consultant

Email is a powerful and flexible way to extend the capabilities of your Rails application. It’s a familiar and low friction way for users to interact with your app.

As much as you may want your users to access your app, they may not need to. Email is a great example of focusing on the problem at hand instead of an over-complicated solution.

We’ll take a deeper look at Action Mailbox and how to route and process your inbound emails.

### [Dungeons and Developers: Uniting Experience Levels in... by Chantelle Isaacs](https://www.youtube.com/watch?v=NHuJNDB8Dt8&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=36)

Chantelle Isaacs
LEARN Academy Career Services Manager

Join us in “Dungeons and Developers,” a unique exploration of team dynamics through the lens of Dungeons & Dragons. Discover how the roles and skills in D&D can enlighten the way we build, manage, and nurture diverse engineering teams. Whether you’re a manager aiming to construct a formidable team (Constitution) or an individual seeking to self-assess and advance your career (Charisma), this talk will guide you in leveraging technical and transferable talents. Together we’ll identify your developer archetype and complete a 'Developer Character Sheet'—our tool for highlighting abilities, proficiencies, and alignment in a fun, D&D-inspired format. Developers and managers alike will leave this talk with a newfound appreciation for the varied skills and talents each person brings to the table.

### [From RSpec to Jest: JavaScript testing for Rails devs by Stefanni Brasil](https://www.youtube.com/watch?v=9ewZf4gK_Gg&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=37)

Stefanni Brasil
Co-founder @hexdevs | Senior Developer @thoughtbot | Core-maintainer of faker-ruby

Do you want to write JavaScript tests but feel stuck transferring your testing skills to the JavaScript world? Do you wish that one day you could write JS tests as confidently as you write Ruby tests? If so, this talk is for you.
Let’s face it: JavaScript isn’t going anywhere. One way to become more productive is to be confident with writing JavaScript automated tests.
Learn how to use Jest, a popular JavaScript testing framework. Let's go through the basics of JavaScript Unit testing with Jest, gotchas, and helpful tips to make your JS testing experience more joyful.
By the end of this talk, you’ll have added new skills to your JS tests toolbox. How to set up test data, mock HTTP requests, assert elements in the DOM, and more helpful bites to cover your JavaScript code confidently.

### [Glimpses of Humanity: My Game-Building AI Pair by Louis Antonopoulos](https://www.youtube.com/watch?v=tOhJ-OHmQRs&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=38)

Louis Antonopoulos
Development Team Lead, thoughtbot

I built a Rails-based game with a partner...an AI partner!

Come see how I worked with my associate, Atheniel-née-ChatGPT, and everything we achieved.

Leave with an improved understanding of how to talk to that special machine in your life ❤️❤️❤️ and an increased sense of wonder at how magical an extended machine-human conversation can be.

I'll be taking you through our entire shared experience, from discovering and iterating on our initial goals, to coming up with a project plan, to developing a working product.

This is not "AI wrote a game" -- this is "Learn how to pair with an artificial intelligence as if they were a human partner, and push the boundaries of possibility!"

### [Beyond senior: lessons from the technical career path by Dawn Richardson](https://www.youtube.com/watch?v=r7g6XicVZ1c&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=39)

Dawn Richardson
Principal Engineer @Thinkific

Staff, principal, distinguished engineer - there is an alternate path to people management if continuing up the "career ladder" into technical leadership. As a relatively new 'Principal Engineer', I want to report back on my learnings so far; things I wish I had known before stepping into this role 3 years ago.

### [Progressive Web Apps with Ruby on Rails by Avi Flombaum](https://www.youtube.com/watch?v=g_0OaFreX3U&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=40)

Avi Flombaum
Avi ❤️ Ruby on Rails and has been building with Rails for over 15 years. He's passionate about Rails being the best way to build web powered applications.

Progressive Web Apps (PWAs) have emerged as a solution for offering the seamless experience of native apps combined with the reach and accessibility of the web. This talk will dive into building an offline-first RSS feed reader that leverages the full potential of PWAs such as Service Workers, Background Sync,

We'll explore how to register, install, and activate a service worker in a Rails application.

We'll delve into the Push API integrated with service workers, discussing how to subscribe users to notifications.

We'll cover setting up background sync in our service worker, creating a system that automatically updates the cached RSS feeds and articles.

The talk will not only solidify the concepts discussed but also provide attendees with a clear roadmap to developing their PWAs.

### [Using Postgres + OpenAI to power your AI Recommendation... by Chris Winslett](https://www.youtube.com/watch?v=eG_vFj5x4Aw&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=41)

Chris Winslett
Product @ Crunchy Bridge

Did you know that Postgres can easily power a recommendation engine using data from OpenAI? It's so simple, it will blow your mind.

For this talk, we will use Rails, ActiveRecord + Postgres, and OpenAI to build a recommendation engine. Then, in the second half, we'll present optimization and scaling techniques because AI data is unique for the scaling needs.

### [Closing Keynote by Aaron Patterson](https://www.youtube.com/watch?v=--0pXVadtII&list=PLbHJudTY1K0chrs_E_XFz2pOJ3d8jCayh&index=43)

Aaron Patterson
Rails Core, Staff @ Shopify
