# RailsConf 2021

Overview and notes from RailsConf 2021.

## Links

* [RailsConf 2021 playlist](https://www.youtube.com/watch?v=N5g7oruepIg&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6)
* [RailsConf 2021 workshop playlist](https://www.youtube.com/watch?v=Sid39aN_SKk&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz)
* [railsconf.org](https://railsconf.org/)
* [twitter.com/railsconf](https://twitter.com/railsconf)
* [RubyConf 2020 blow by blow](https://www.alchemists.io/articles/ruby_conf_2020/) - Brooke Kuhlmann

## Keynote Speakers

* [David Heinemeier Hansson](https://www.youtube.com/watch?v=1lV3WL6ypIU&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=4)
* [Eileen M. Uchitelle](https://www.youtube.com/watch?v=FU9wz998-1k&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=6)
* [Aaron Patterson](https://www.youtube.com/watch?v=qgZ4YLO0pYE&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=3)
* [Bryan Cantrill](https://www.youtube.com/watch?v=nY07zWzhyn4&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=5)
* [Bryan Liles](https://www.youtube.com/watch?v=5I1WuOn5MYo&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=2)

## Talks

### [Hiring is Not Hazing](https://www.youtube.com/watch?v=KLHYZT2I28k&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=8)

Tech hiring has a bad reputation for a reason - it's usually awful. But it doesn't have to be that way. In this talk, we'll dive into what is wrong with many current tech hiring practices and what you can do instead. You'll learn ways to effectively assess technical ability, what makes a great interview question, how to be more inclusive, the pros and cons of giving homework assignments, and much more. You'll leave with ideas to improve your interviews, and ways to influence your company to change their hiring practices.

> Aja Hammerly. Aja lives in Seattle where she is a Developer Advocate at Google and a member of the Seattle Ruby Brigade. Her favorite languages are Ruby and Prolog. She also loves working with large piles of data. In her free time she enjoys skiing, cooking, knitting, and long coding sessions on the beach.

### [What Poetry Workshops Teach Us about Code Review](https://www.youtube.com/watch?v=gsjpIDcJWpM&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=9)

Code review is ostensibly about ensuring quality code and preventing errors, bugs, and/or vulnerabilities from making their way to production systems. Code review, as practiced, is often top-down, didactic, and in many cases not particularly useful or effective. By looking at the creative writing workshop model (and strategies for teaching and providing feedback on writing), we can extract patterns that help us to have more effective, more efficient, and more enjoyable code reviews. Not only can we make our code better, we can also help our teams better understand the codebase and communicate better, and thus do more effective and enjoyable work (with perhaps better team cohesion).

> Andrew Ek is a senior partner at Arid Software. He builds products for clients using Elixir, Ruby, and Javascript. Before becoming a software developer, he taught middle and high school language arts, high school math, and college-level computer science. Andrew lives in Lincoln, Nebraska, with his remarkably excellent spouse and kiddo, and their very adequate cats.

### [10 Years In - The Realities of Running a Rails App Long Term](https://www.youtube.com/watch?v=Xd41xwQNYbY&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=10)

The first commit for the DNSimple application was performed in April 2010, when Ruby on Rails was on version 2.3. Today DNSimple still runs Ruby on Rails, version 6.0. The journey from of the DNSimple application to today's version is a study in iterative development. In this talk I will walk through the evolution of the DNSimple application as it has progressed in step with the development of Ruby on Rails. I'll go over what's changed, what's stayed the same, what worked, and where we went wrong.

> Anthony Eden is the founder of DNSimple, a 25-year software developer, and a seasoned international speaker. In addition to bootstrapping DNSimple, Anthony has been an early-stage member of numerous small businesses and startups since the late 90s. Anthony has a large portfolio of open source projects that he either created or contributed to, using multiple languages including Java, Python, Ruby, Clojure, Go, Erlang and Elixir.

### [The Trail to Scale Without Fail: Rails?](https://www.youtube.com/watch?v=_t9z9YVPCm8&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=11)

Let's be blunt: Most web apps aren’t so computation-heavy and won't hit scaling issues.
What if yours is the exception? Can Rails handle it?
Cue Exhibit A: Cloudinary, which serves billions of image and video requests daily, including on-the-fly edits, QUICKLY, running on Rails since Day 1. Case closed?
Not so fast. Beyond the app itself, we needed creative solutions to ensure that, as traffic rises and falls at the speed of the internet, we handle the load gracefully, and no customer overwhelms the system.
The real question isn't whether Rails is up to the challenge, but rather: Are you?

> Ariel Caplan. Ariel works as a software engineer at Cloudinary, trying to bend the curve to achieve both code quality and great performance. In his experience, seeking multiple perspectives is the greatest tool available.

### [Effective Data Synchronization between Rails Microservices](https://www.youtube.com/watch?v=LxxcHcBU4Bk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=12)

Data consistency in a microservice architecture can be a challenge, especially when your team grows to include data producers from data engineers, analysts, and others.

How do we enable external processes to load data onto data stores owned by several applications while honoring necessary Rails callbacks? How do we ensure data consistency across the stack?

Over the last five years, Doximity has built an elegant system that allows dozens of teams across our organization to independently load transformed data through our rich domain models while maintaining consistency. I'd like to show you how!

> Austin Story. Hi, I'm Austin. I am a Senior Engineer and Manager at Doximity. I love rails and the omakase philosophy of the ecosystem. Please reach out if you have any questions. twitter: @austio36

### [Self-Care on Rails](https://www.youtube.com/watch?v=svkvjzyXJkU&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=13)

This past year has been one of the most challenging years in recent memory. The pandemic has taken a toll, including on children.

Adults used their professional skills to help make the year a little better for the kids in our lives: Therapists counseled, entertainers delighted, teachers educated... and Rails developers developed!

In this talk, I'll share the apps I built on Rails that helped my kids and me cope, celebrate and persevere through the year.

In 2020, tech was pivotal in keeping us going, and for my kids, Rails made the year a little more manageable.

> Ben Greenberg. Ben is a second career developer who previously spent a decade in the fields of adult education, community organizing, and non-profit management. He works as the Ruby developer advocate for Vonage by day and experiments with open source projects at night. He writes regularly on the intersection of community development and tech. Originally from Southern California and a long time resident of New York City, Ben now resides near Tel Aviv.

### [Debugging: Techniques for Uncertain Times](https://www.youtube.com/watch?v=EiBrQin0nbU&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=14)

When we learn to code, we focus on writing features while we understand what the code is doing. When we debug, we don’t understand what our code is doing. The less we understand, the less likely it is that our usual programming mindset—the one we use for feature development—can solve the problem.

It turns out, the skills that make us calmer, more effective debuggers also equip us to deal with rapid, substantial changes to our lives.

Whether you’re uncertain about what’s going on in your code, your life, or both, in this talk you’ll learn debugging techniques to get you moving forward safely.

> Chelsea Troy writes code for mobile, the web, and machine learning models. She consulted with Pivotal Labs before launching her own firm to focus on clients who are saving the planet, advancing basic scientific research, or helping underserved communities. Chelsea live streams her programming work on NASA-funded mobile and server projects, and she teaches Mobile Software Development at the University of Chicago. Off the computer, you'll find Chelsea with a barbell or riding her ebike, Gigi.

### [Realtime Apps with Hotwire & ActionMailbox](https://www.youtube.com/watch?v=BQhWfLp6UbU&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=15)

Hotwire enables realtime activity in our Rails application with very little Javascript. We'll build a realtime customer support application in just a few minutes using Hotwire for realtime updates and ActionMailbox for handling inbound emails.

> Chris Oliver. Chris is the founder of GoRails, host of the Remote Ruby podcast, and creator of Jumpstart and Hatchbox.io. He loves building tools to make developers' lives easier and helping people learn to code.

### [The Rising Storm of Ethics in Open Source](https://www.youtube.com/watch?v=0I70wz9Qa44&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=16)

The increased debate around ethical source threatens to divide the OSS community. In his book "The Structure of Scientific Revolutions", philosopher Thomas Kuhn posits that there are three possible solutions to a crisis like the one we're facing: procrastination, assimilation, or revolution. Which will we choose as we prepare for the hard work of reconciling ethics and open source?

> Coraline Ada Ehmke is at the forefront of the debate on ethics in open source. She is an internationally recognized activist, speaker, writer, and engineer with nearly 30 years of industry experience. In 2014 Coraline created the Contributor Covenant, the first code of conduct for open source communities. In 2019 she authored the Hippocratic License, an Ethical Open Source license, and founded the Ethical Source Movement.

### [Processing data at scale with Rails](https://www.youtube.com/watch?v=dB47P6H5U2Q&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=17)

More of us are building apps to make sense of massive amounts of data. From public datasets like lobbying records and insurance data, to shared resources like Wikipedia, to private data from IoT, there is no shortage of large datasets. This talk covers strategies for ingesting, transforming, and storing large amounts of data, starting with familiar tools and frameworks like ActiveRecord, Sidekiq, and Postgres. By turning a massive data job into successively smaller ones, you can turn a data firehose into something manageable.

> Corey Martin. After working in government, I became a Rails developer by taking an online course and moonlighting. I've developed with Rails for over 8 years, starting with a cooking app. Currently, I'm a software engineer at Stripe. I live with my husband and an English Mastiff in Washington, DC.

### [Designing APIs: Less Data is More](https://www.youtube.com/watch?v=RD2gj73w4pc&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=26)

Often developers design APIs that expose more than is needed - unnecessary fields, redundant relationships, and endpoints that no one asked for.

These kinds of practices later on introduce communication overhead, extra maintenance costs, negative performance impacts, and waste time that could have been spent better otherwise.

We'll walk through how to design minimal APIs that are straight forward to use, and that are exactly what our consumers need!

> Damir Svrtan.  Lead Software Engineer at Netflix. Strong advocate of clean coding, automated testing and passionate about constant improvement. Former organizer of Ruby Meetups in Zagreb, blogger, open source lover and contributor. More info: <http://damir.svrtan.me/talks/> <http://damir.svrtan.me/blog-posts/>

### [Serverless Rails: Understanding the pros and cons](https://www.youtube.com/watch?v=jjyl3aY6Utc&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=27)

Serverless is widely lauded as the ops-free future of deployment. Serverless is widely panned as a gimmick with little utility for the price. Who’s right? And what does it mean for my Rails app?

This session takes a critical look at serverless hosting. We’ll consider the abstractions underlying environments such as AWS Lambda and Google Cloud Run, their assumptions and trade-offs, and their implications for Ruby apps and frameworks. You’ll come away better prepared to decide whether or not to adopt serverless deployment, and to understand how your code might need to change to accommodate it.

> Daniel Azuma is a senior engineer at Google, where he leads the Ruby and Elixir teams, building libraries and tools to help his favorite language communities use Google Cloud Platform. He lives with his wife in the Seattle area, and enjoys traveling the outdoors, playing the piano, and having deep conversations with cats.

### [Make a Difference with Simple A/B Testing](https://www.youtube.com/watch?v=cCqwPHiCBQk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=28)

There are a lot of myths around A/B testing. They’re difficult to implement, difficult to keep track of, difficult to remove, and the costs don’t seem to outweigh the benefits unless you’re at a large company. But A/B tests don’t have to be a daunting task. And let’s be honest, how can you say you’ve made positive changes in your app without them?

A/B tests are a quick way to gain more user insight. We'll first start with a few easy A/B tests, then create a simple system to organise them. By then end, we'll see how easy it is to convert to a (A/B) Test Driven Development process.

> Danielle Gordon. Danielle is a software engineer at Nift, where she does Rails, iOS, and Android development. She has a passion for clean code and a goal of baking a new flavour of macarons every month.

### [Speed up your test suite by throwing computers at it](https://www.youtube.com/watch?v=T3TipTdx_2k&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=29)

You've probably experienced this. CI times slowly creep up over time and now it takes 20, 30, 40 minutes to run your suite. Multi-hour runs are not uncommon.

All of a sudden, all you're doing is waiting for CI all day, trying to context switch between different PRs. And then, a flaky test hits, and you start waiting all over again.

It doesn't have to be like this. In this talk I'll cover several strategies for improving your CI times by making computers work harder for you, instead of having to painstakingly rewrite your tests.

> Daniel Magliola. Life-long coder, expert procrastinator, and occasional game programmer obsessed with code performance and weird Lego machinery.

### [Turning DevOps Inside-Out](https://www.youtube.com/watch?v=kM-AzeN016c&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=73)

We often think of automation and deployment scripts when we discuss DevOps, however the true value is in reacting to how customers use your application and incorporating this feedback into your development lifecycle. In this talk, we will discuss how you can turning DevOps around to increase your feature velocity, including some Rails specific strategies and gems you can use to get things done faster.

> Darren Broemmer. Darren discovered Ruby later in life but has never looked back. He is the Developer Evangelist for Engine Yard, a data-driven, NoOps PaaS solution for deploying and managing applications on AWS. His blog series, Ruby Unbundled, explores topics in Ruby and Rails architecture to help drive developer productivity and release features faster.

### [The Power of Visual Narrative](https://www.youtube.com/watch?v=LIQj2audnwo&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=30)

As technologists, we spend a great deal of time trying to become better communicators. One secret to great communication is... to actually say less. And draw more!

I've been using sketchnotes, comics, and abstractly-technical doodles for the last few years to teach myself and others about technical concepts. Lo-fi sketches and lightweight storytelling devices can create unlikely audiences for any technical subject matter. I'll break down how my brain translates complex concepts into approachable art, and how anyone can start to do the same, regardless of previous artistic experience.

> Denise Yu. Denise is a Senior Software Engineer at GitHub, where she builds tools to make Open Source software development better for communities. Denise has previously delivered conference talks on topics ranging from continuous delivery to functional programming to scaling company culture. When she's not coding, she is often doodling sketch notes that break down technical concepts into digestible pieces at deniseyu.io/art.

### [When words are more than just words: Don't BlackList us](https://www.youtube.com/watch?v=3UWpTpOdLTg&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=31)

How we communicate words is important, the code, test and documentation needs to be part of the ongoing process to treat better our coworkers, be clear on what we do without the need of established words as "blacklist". Do you mean restricted? rejected? undesirable? think again.

Master, slave, fat, archaic, blacklist are just a sample of actions you may not be aware of hard are for underrepresented groups. We, your coworkers can't take it anymore because all the suffering it create on us, making us unproductive, feeling second class employee or simply sad.

Let's make our code, a better code.

> Espartaco Palma. A Senior Software Engineer now applying Ruby as a daily basis, having a full conversation with datasets, collections and queries all day long. Reviewing code and learning how to de-bloat the un-bloatable. I have been programming on many languages,

### [How to A/B test with confidence](https://www.youtube.com/watch?v=rXOx9CckoEo&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=32)

A/B tests should be a surefire way to make confident, data-driven decisions about all areas of your app - but it's really easy to make mistakes in their setup, implementation or analysis that can seriously skew results!

After a quick recap of the fundamentals, you'll learn the procedural, technical and human factors that can affect the trustworthiness of a test. More importantly, I'll show you how to mitigate these issues with easy, actionable tips that will have you A/B testing accurately in no time!

> Frederick Cheung. I started deep in the bit mines, programming in C, but picked up Ruby in 2006 and haven't looked back since. I'm the CTO at Dressipi where I like to think about recommender systems, infrastructure and web applications.

### [Profiling to make your Rails app faster](https://www.youtube.com/watch?v=AFpq1pDQagw&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=33)

As you grow your Rails app, is it starting to slow down? Let’s talk about how to identify slow code, speed it up, and verify positive change within your application. In this talk, you’ll learn about rack-mini-profiler, benchmark/ips, and performance optimization best practices.

> Gannon McGibbon. Gannon is a software developer currently working at Shopify. He is a member of the Ruby on Rails committers team and has contributed to many other open source Ruby projects. His hobbies include advocating for open source, owning a cat, and eating unreasonably spicy food.

### [Why I'm Closing Your GitHub Issue](https://www.youtube.com/watch?v=9haaAtjWVy0&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=34)

Do you feel panic when receiving a notification from your open-source project? Is a backlog of unanswered issues wearing you down?

You wanted to put something out there for others to use, but now it feels like a second job. Keep stressing out like this and you will burn out and leave another project abandoned on GitHub.

In my talk we will rediscover your personal reasons for doing open source in the first place. We will practice dealing with issues effectively to free up time for the work that motivates you.

> Henning Koch. Henning discovered Ruby in 2004 and has been publishing open-source code for 12 years. His current time sink is Unpoly, an unobtrusive JavaScript framework for server-side web applications. At day Henning works as head of development at makandra, where he trains young developers and maintains vintage versions of Rails. Henning is a father of young twins and lives in Germany. Twitter: @triskweline

### [Hotwire Demystified](https://www.youtube.com/watch?v=Q7uOPVfZ3Go&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=35)

DHH stunned the Rails world with his announcement of Hotwire from Basecamp. Even folks in the non-Rails web-development community took notice.

In this talk, you will learn about the building blocks of Hotwire and how they compose to create a streamlined development experience while writing little to no JavaScript.

> Jamie Gaskins. Jamie (he/him) is a Principal Site Reliability Engineer at Forem/DEV. His interests include telling computers what to do and crying when they do what he told them to instead of what he actually wanted.

### [Engineer in Diversity & Inclusion - Tangible Steps for Teams](https://www.youtube.com/watch?v=VqjD7vsDlTk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=36)

When it comes to implementing Diversity, Equity, and Inclusion (“DEI”), where do software engineers fit in? The technology we build is used by diverse groups of people, so our role is to build platforms for that diversity. At this talk, you will learn why and how to make DEI a priority in your work with tangible steps, goals, and examples. While the scope of these topics can feel overwhelming, you will leave this talk empowered with the tools to attend your next standup or write that next line of code as a better community member, ally, and software engineer.

> Jeannie Evans. Jeannie (she/her) is a Software Engineer at Snapdocs. Before getting her start in tech, Jeannie spent a decade working in non-profits and education both here and abroad. She now lives in Denver with her girlfriend and large cat, Zombie. When she's not working, Jeannie loves to play music, adventure in the Rockies, and be Tía Jeannie to her young nieces.

### [A Day in the Life of a Ruby Object](https://www.youtube.com/watch?v=PuNbdfdFBjk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=37)

Your code creates millions of Ruby objects every day, but do you actually know what happens to these objects?

In this talk, we’ll walk through the lifespan of a Ruby object from birth to the grave: from .new to having its slot reallocated. We’ll discuss object creation, the Ruby object space, and an overview of garbage collection.

Along the way, we’ll learn how to make our apps more performant, consume less memory, and have fewer memory leaks. We’ll learn specific tips and pointers for how to see what the garbage collector is doing and how to take advantage of the strategies it employs.

> Jemma Issroff. Jemma Issroff is currently writing a book about managed garbage collection, with a focus in Ruby. An avid Ruby blogger, she also writes the “Tip of the Week” for Ruby Weekly. Jemma has worked extensively optimizing backend memory usage and performance in Rails apps through which she has learned about the depths of Ruby objects. She is excited to share her passion for Ruby with you!

### [Stimulating Events](https://www.youtube.com/watch?v=4sr608kgcrk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=38)

Stimulus JS bills itself as a framework with modest ambitions that fits nicely into the Rails as "omakase" paradigm. At its core, Stimulus gives Rails developers a new set of low effort, high impact tools that can add much more than the sheen of modernization to an everyday Rails application. Join me as I live code three Stimulus JS examples that will help you save time, impress your friends, and win new clients and opportunities. This will be great for JS newbies and experts alike along with anyone interested in the potential schadenfreude that watching me live code will likely elicit.

> Jesse Spevack. I am a staff engineer at Ibotta, a cash back for shopping mobile app. Before getting into the tech world, I worked in public K-12 education for 11 years. I transitioned from education into technology by way of the Turing School of Software Design, a Denver based code school with a Ruby-centric curriculum.

### [Strategic Storytelling](https://www.youtube.com/watch?v=QqIpEkA6aIo&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=39)

We come from a world of facts and metrics so obviously the people with the most data wins, right? Engineering comes from a place of logic but telling the story behind that information is how the best leaders get buy-in and support for their plans. In this talk, we'll examine the how and why of storytelling, develop a framework of putting an idea into a narrative, and what tools you’ll need to complement a good story. By the end, you’ll be able to break out a story whenever you need to generate excitement, find advocates, or more budget. Is there anything more irresistible than a good story?

> Jessica Hilt is the bossy boss of an engineering team for the University of California San Diego. She can be persuaded to discuss (ad nauseam) community building, EQ, and creative writing. In her spare time, she writes horror and teaches nonfiction performance storytelling, sometimes at the same time.

### [ViewComponents in the Real World](https://www.youtube.com/watch?v=QoetqsBCsbE&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=40)

With the release of 6.1, Rails added support for rendering objects that respond to render_in, a feature extracted from the GitHub application. This change enabled the development of ViewComponent, a framework for building reusable, testable & encapsulated view components. In this talk, we’ll share what we’ve learned scaling to hundreds of ViewComponents in our application, open sourcing a library of ViewComponents, and nurturing a thriving community around the project, both internally and externally.

> Joel Hawksley. Joel is a software engineer at GitHub and the creator of ViewComponent.

### [Type Is Design:Fix Your UI with Better Typography and CSS](https://www.youtube.com/watch?v=now-iSUUQZc&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=41)

The written word is the medium through which most information exchanges hands in the tools we build. Digital letterforms can help or hinder the ability for people to communicate and understand. We'll work through some typographic principles and then apply them to the web with HTML and CSS for implementation. We'll look at some of the newer OpenType features and touch on the future of digital type, variable fonts, and more.

> John Athayde is a designer and developer who spends a lot of time fighting bad coding practices in the Rails view layer. He is currently the VP of Design at PowerFleet. He's been writing HTML and CSS by hand since 1995. Yes, his beard is graying. No, it does not connect to his sweater. He lives with his wife, four kids, and menagerie of goats, chickens, dogs, and cats on a small farm outside Charlottesville, Virginia.

### [Beautiful reactive web UIs, Ruby and you](https://www.youtube.com/watch?v=bwsVgCb97v0&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=42)

A lot of life changing things have happened in 2020. And I'm obviously speaking about Stimulus Reflex and Hotwire and how we as Rails devs are finally enabled to skip a lot of JS while implementing reactive web UIs. But what if I told you, there's room for even more developer happiness? Imagine crafting beautiful UIs in pure Ruby, utilizing a library reaching from simple UI components representing basic HTML tags over styled UI concepts based on Bootstrap to something like a collection, rendering reactive data sets. Beautiful, reactive web UIs implemented in pure Ruby are waiting for you!

> Jonas Jabari. Jonas is a self-employed software developer. For years he struggled with increasing complexity of web app development caused by adding a JS frontend application instead of using the UI layer of Rails. He decided to fight against this complexity and created Matestack enabling Rails developers to implement reactive UIs in pure Ruby while enjoying highest developer happiness. Speaking of happiness: In his spare time he enjoys a good coffee and memes of funny dogs (and sometimes cats).

### [Refactoring: A developer's guide to writing well](https://www.youtube.com/watch?v=BbIILUSmSk4&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=43)

As a developer, you're asked to write an awful lot: commit messages, code review, achitecture docs, pull request write-ups, and more. When you write, you have the power to teach and inspire your teammates—the reader—or leave them confused. Like refactoring, it's a skill that can elevate you as a developer but it is often ignored.

In this session, we'll use advice from fiction authors, book editors, and technical writers to take a pull request write-up from unhelpful to great. Along the way, you'll learn practical tips to make your code, ideas, and work more clear others.

> Jordan Raine is a senior developer at GitHub, where he works on UI systems that make it easier to do good work. He enjoys refactoring code and editing words. At past conferences, Jordan has spoken about code spelunking and iteratively upgrading Rails apps.

### ["Junior" Devs are the Solution to Many of Your Problems](https://www.youtube.com/watch?v=tD4Otpo0_zI&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=44)

Our industry telegraphs: "We don't want (or know how to handle) 'junior developers*'."

Early-career Software Developers, or ECSDs, have incredible value if their team/company/manager doesn't "lock themselves out" of accessing this value.

Whoever figures out how to embrace the value of ECSDs will outperform their cohort. 📈💰🤗

I will speak to:

* Executives (CTOs/Eng VPs)
* Senior Developers/Dev Managers
* ECSDs themselves

About how to:

* Identify which problems are solvable because of ECSDs
* Get buy-in for these problem/solution sets
* Start solving these problems with ECSDs

> Josh Thompson. I have been a newbie and an expert, while training newbies and experts, in domains where injuries could be fatal, for decades. I've got an understanding of what it's like to convey knowledge to others, and an understanding of others conveying knowledge to me. I'm an expert at what it's like on both sides of the equation, and I've got all kinds of knowledge about the many positive 2nd-order effects. I'm a graduate of a code school (Turing), and I've mentored students/grads since 2017.

### [Exploring Real-time Computer Vision Using ActionCable](https://www.youtube.com/watch?v=eG9_ngMwYGk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=45)

Learn about combining Rails and Python for Computer Vision. We'll be analyzing images of cannabis plants in real-time and deriving insights from changes in leaf area & bud site areas. We'll explore when to use traditional statistical analysis versus ML approaches, as well as other ways CV has been deployed. We’ll cover integrating OpenCV with ActionCable & Sidekiq for broadcasting camera analysis to Rails and creating time-lapse style renderings with graphs. You will gain an understanding of what tools to use and where to start if you’re interested in using ML or CV with your Rails project!

> Justin Bowen. With over a decade of experience as an engineer contributing to startups in roles from senior software engineer to CTO, Justin has no degrees, but believes the best skills are humility and knowing that there is always more to learn. On the side of his day jobs, Justin has spent the past five years building smart cameras integrated with machine learning algorithms for the agriculture industry. He would like to show other Rails developers when and how to apply machine learning to their work.

### [Implicit to Explicit: Decoding Ruby's Magical Syntax](https://www.youtube.com/watch?v=rssgWqJq-14&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=46)

Does a Rails model or config file seem like a magical syntax? Or can you read any Ruby code and understand it as the interpreter does?

Ruby's implicitness makes it great for readability and DSLs. But that also gives Ruby a "magical" syntax compared to JavaScript.

In this talk, let's convert the implicit to explicit in some familiar Rails code. What was "magic" will become simple, understandable code.

After this talk, you'll see Ruby through a new lens, and your Ruby reading comprehension will improve. As a bonus, I'll share a few Pry tips to demystify any Ruby code.

> Justin Gordon. Justin has been writing Ruby code since 2012 and contributing to the Ruby community via articles and open source since then. In 2015, he created the gem "React on Rails," which integrated server-side rendered React and Webpack with Rails long before the Webpacker gem. These days, as CEO of ShakaCode.com, he helps companies optimize their Rails websites. He and his ShakaCode team also build Rails apps with modern front-ends, including their startup app, HiChee.com.

### [The History of Making Mistakes](https://www.youtube.com/watch?v=har1kdHqCDw&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=48)

We sometimes say “computers were a mistake”, as if clay tablets were any better. From the very beginning, humans have been screwing up, and it’s only gotten worse from there. Each time, though, we’ve learned something and moved forward. Sometimes we forget those lessons, so let’s look through the lens of software engineering at a few of these oopsie-daisies, and see the common point of failure - humans themselves.

> Kerri Miller is a Software Engineer and Team Lead currently based in the Pacific Northwest. She has worked at companies large and small, mentors and teaches students, and still finds time to work on Open Source projects and organize multiple conferences every year. Having an insatiable curiosity, she has worked as a lighting designer, marionette puppeteer, sous chef, and poker player, and enjoys hiking, collecting yoyos, working with glass, and riding her motorcycle around North America.

### [High availability by offloading work](https://www.youtube.com/watch?v=RRvA5U_fE40&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=47)

Unpredictable traffic spikes, slow requests to a third party, and time-consuming tasks like image processing shouldn’t degrade the user facing availability of an application. In this talk, you’ll learn about different approaches to maintain high availability by offloading work into the background: background jobs, message oriented middleware based on queues, and event logs like Kafka. I’ll explain their foundations and how they compare to each other, helping you to choose the right tool for the job.

> Kerstin Puschke. Kerstin is a developer transforming Shopify’s massive Rails code base into a more modular monolith, building on her prior experience with distributed microservices architectures. She used to run the Hamburg Ruby user group and her local Rails Girls chapter. While she loves visiting warm and sunny cities, the Canadian winter has revived her passion for skiing.

### [How to teach your code to describe its own architecture](https://www.youtube.com/watch?v=nutSgxia22I&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=49)

Architecture documents and diagrams are always out of date. Unfortunately, lack of accurate, up-to-date information about software architecture is really harmful to developer productivity and happiness. Historically, developers have overcome other frustrations by making code the “source of truth”, and then using the code as a foundation for automated tools and processes. In this talk, I will describe how to automatically generate docs and diagrams of code architecture, and discuss how to use to use this information to improve code understanding and code quality.

> Kevin Gilpin. Kevin is a CTO and entrepreneur with over 20 years of experience in fields such as developer tools, cybersecurity, healthcare, automotive, logistics, and life sciences. He’s a founder of code quality startup AppLand, and was previously founder and CTO of DevSecOps startup Conjur (acquired by CyberArk in 2107). Kevin has been an active Rails developer since 2008, and both AppLand and Conjur are built on Rails.

### [Engineering MBA: Be The Boss of Your Own Work](https://www.youtube.com/watch?v=6ldCGo29w5g&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=50)

Improve your work as a developer with an introduction to strategic planning, situational leadership, and process management. No balance sheets or income statements here; join me to learn the MBA skills valuable to developers without the opportunity costs of lost wages or additional student loans.

Demystify the strategic frameworks your management team may use to make decisions and learn how you can use those same concepts in your daily work. Explore the synergy one developer achieved by going to business school (sorry, the synergy comment slipped out - old habit).

> Kevin Murphy. Kevin utilizes the knowledge learned as a business school graduate every day as a software developer. As proof of how great at business he is, he’s giving all of this information away: for free. Kevin lives near Boston where he is a Software Developer at The Gnar Company.

### [Who Are You? Delegation, Federation, Assertions and Claims](https://www.youtube.com/watch?v=PRZn0QyQvPI&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=51)

Identity management? Stick a username and (hashed) password in a database, and done! That's how many apps get started, at least. But what happens once you need single sign-on across multiple domains, or if you'd rather avoid the headache of managing those passwords to begin with? This session will cover protocols (and pitfalls) for delegating the responsibility of identity management to an outside source. We'll take a look at SAML, OAuth, and OpenID Connect, considering both the class of problems they solve, and some new ones they introduce!

> Lyle Mullican is a principal engineer at Handle Financial. Before the fintech industry, he spent many years developing clinical laboratory applications. He started using Rails at version 1 and has run production applications on every major version since. Originally from a design background, he still occasionally manages to produce fine art.

### [API Optimization Tale: Monitor, Fix and Deploy (on Friday)](https://www.youtube.com/watch?v=6BsfJqk_YTA&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=52)

I saw a green build on a Friday afternoon. I knew I need to push it to production before the weekend. My gut told me it was a trap. I had already stayed late to revert a broken deploy. I knew the risk.

In the middle of a service extraction project, we decided to migrate from REST to GraphQL and optimize API usage. My deploy was a part of this radical change.

Why was I deploying so late? How did we measure the migration effects? And why was I testing on production? I'll tell you a tale of small steps, monitoring, and old tricks in a new setting. Hope, despair, and broken production included.

> Maciek Rząsa. Software engineer specialising in Ruby with ~10 years of experience in various domains. Interested in distributed systems, self-organising teams and writing software that matters. At Toptal where he works, he is involved in a Billing Extraction project in which a complex domain of billing is isolated as a separate service. Knowledge sharing advocate. Co-organiser of Rzeszów Ruby User Group. Speaker at technical conferences and meetups. Instructor at Rzeszów University of Technology.

### [Using Rails to communicate with the New York Stock Exchange](https://www.youtube.com/watch?v=oZNeMCj5hgY&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=53)

This is a timely talk because of what happened with Gamestop/Robinhood, introducing a case of a high-frequency trading app like Robinhood, built on top of Rails, and how it proves it can scale, managing not only over a complex HTTP API but also communicating over an internal protocol TCP with one New York Stock Exchange server by making use of Remote Procedure Calls (RPC) with RabbitMQ to be able to manage transactional messages (orders).

So, how can we make use of Rails to deliver a huge amount of updates (through WSS) and have solid transactions (through HTTPS)?

> Martin Jaime Morón is a Software Engineer at Rootstrap. He was born in Uruguay and went to the Universidad de la Republica where he got his degree in Computer Engineering. Martin is a Ruby developer and CI-CD enthusiast.

### [rails db:migrate:even_safer](https://www.youtube.com/watch?v=Jvnx1CUPPJk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=54)

It's been a few years, your Rails app is wildly successful, and your database is bigger than ever. With that, comes new challenges when making schema changes. You have types to change, constraints to add, and data to migrate... and even an entire table that needs to be replaced.

Let's learn some advanced techniques for evolving your database schema in a large production application, while avoiding errors and downtime. Remember, uptime begins at $HOME!

> Matt Duszynski. Matt is a software engineer from Texas that headed out Californee way lookin' for some internet. He currently lives and breathes Ruby at Weedmaps, the greenest tech company around. After exiting vim, he enjoys analog activities such as golf, woodworking, and entertaining his slightly neurotic cat. He can plug a USB cable in the right way around first time, every time.

### [Rescue Mission Accomplished](https://www.youtube.com/watch?v=NjG8FfcudnM&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=55)

"Your mission, should you choose to accept it..." A stakeholder has brought you a failing project and wants you to save it.

Do you accept your mission? Do you scrap the project and rewrite it? Deciding to stabilize a failing project can be a scary challenge. By the end of this talk, you will have tangible steps to take to incrementally refactor a failing application in place. We will also be on the lookout for warning signs of too much tech debt, learn when tech debt is OK, and walk away with useful language to use when advocating to pay down the debt.

> Mercedes Bernard is VP of Delivery with Tandem, a digital consultancy in Chicago. When she's coding, she loves refactoring and optimizing Rails apps–but most days, she prefers to support teams shipping quality software products while helping them find their strengths. Throughout her career, Mercedes has strived to create a welcoming environment for early-career devs, speaking often about mentorship and coaching. Outside of work, she likes to unplug and enjoys spinning yarn and crocheting.

### [Writing design docs for wide audiences](https://www.youtube.com/watch?v=kF8xhQmOszI&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=56)

What would you do to convince a large audience, who has little context, to use your solution to a problem? One way is to write a design document, which helps scale technical communication and build alignment among stakeholders. The wider the scope of the problem, the more important alignment is. A design document achieves this by addressing three key questions: “what is the goal?”, “how will we achieve it?” and “why are we doing it this way?”. This talk will cover identifying your audience, effectively writing answers to these questions, and involving the right people at the right time.

> Michele Titolo is an experienced lead engineer working on cloud infrastructure at Square. With a career spanning multiple specialties, Michele uses her passion for distributed systems to help teams succeed in the cloud. Outside of work, Michele is a frequent traveler, an avid home cook, and a MMORPG gamer.

### [How Reference Librarians Can Help Us Help Each Other](https://www.youtube.com/watch?v=A2Tr0DWfwAE&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=57)

In 1883, The Boston Public Library began hiring librarians for reference services. Since then, a discipline has grown around personally meeting the needs of the public, as Library Science has evolved into Information Science. Yet, the goal of assisting with information needs remains the same. There is disciplinary overlap between programming and information science, but there are cultural differences that can be addressed. In other words, applying reference library practices to our teams can foster environments where barriers to asking for and providing help are broken down.

> Mike Calhoun. Originally hailing from Syracuse, NY, Mike now lives in Vancouver, WA where he works remotely as a Senior Developer at Invoca. He has worked in computer programming since 2006 after a brief stint as a librarian. In that time, he has primarily chosen Ruby and Ruby on Rails as his technologies of choice and appreciates the time he gets to spend working with them. When not programming, he spends his time with his wife, son, two cats, and one corgi.

### [A Third Way For Open-Source Maintenance](https://www.youtube.com/watch?v=m3GHN3AYAUg&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=58)

Drawing on my experiences maintaining Puma and other open-source projects, both volunteer and for pay, I'd like to share what I think is a "third way" for sustainable open source, between the extremes of "everyone deserves to be paid" and "everyone's on their own". Instead of viewing maintainers as valuable resources, this third way posits that maintainers are blockers to a potentially-unlimited pool of contributors, and a maintainer's #1 job is encouraging contribution.

> Nate Berkopec. Nate is a freelancer and consultant that focuses on Ruby web application performance. Author of The Complete Guide to Rails Performance and blogger at nateberkopec.com. He appeared on Shark Tank, ABC's primetime entrepreneurship show, when he was nineteen years old. Nate recently moved to Taos, New Mexico after eight years in New York City.

### [Can I break this?: Writing resilient “save” methods](https://www.youtube.com/watch?v=TuhS13rBoVY&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=59)

An alert hits your radar, leaving you and your team perplexed. An “update” action that had worked for years suddenly ... didn't. You dig in to find that a subtle race condition had been hiding in plain sight all along. How could this happen? And why now?

In this talk, we'll discover that seemingly improbable failures happen all the time, leading to data loss, dropped messages, and a lot of head-scratching. Plus, we'll see that anyone can become an expert in spotting these errors before they occur. Join us as we learn to write resilient save operations, without losing our minds.

> Nathan Griffith. Nathan built his first Rails application 13 years ago and hasn't been able to stop since (help!). By day, he is a Staff Engineer at Betterment, focused on wrangling cross-cutting platform concerns and on coaching engineers. By night, he sings karaoke. @smudgethefirst / ngriffith.com

### [How to be a great developer without being a great coder](https://www.youtube.com/watch?v=44qVL-cwtyM&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=60)

Learning to code is an individual journey filled with highs and lows, but for some, the lows seem far more abundant. For some learning to code, and even for some professionals, it feels like we're struggling to tread water while our peers swim laps around us. Some developers take more time to build their technical skills, and that’s ok, as being a great developer is about far more than writing code.

This talk looks at realistic strategies for people who feel like they are average-or-below coding skill level, to keep their head above water while still excelling in their career as a developer.

> Nicole Carpenter. Nicole organizes ChicagoRuby and is also a software developer at 8th Light in Chicago, where she hosts their semi-monthly speaker series, 8th Light University. She is a co-organizer of People of Color Code and also volunteers at Code Platoon, a coding bootcamp for veterans based in Chicago.

### [New dev, old codebase: A series of mentorship stories](https://www.youtube.com/watch?v=xqcAUN31qvQ&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=61)

Mentorship in software development carries a lot of responsibility, but plays an integral part in making tech communities as well as individuals thrive.

In this talk, we'll go over some of my mentorship experiences, adopting techniques and learning to teach, so we can teach to learn. Anyone can be a great mentor!

> Ramón Huidobro. Ramón is a software engineering and developer relations contractor based in Vienna, Austria. He's spent the last ten years being directly involved with small businesses and startups getting their apps off the ground or back in shape! His main motivation is community. He's not only actively worked software builders both new and experienced, but also dedicated a time to organising conferences, workshops and other events aimed at helping empower folks in their tech journey.

### [Missing Guide to Service Objects in Rails](https://www.youtube.com/watch?v=XH1fbvexqyU&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=62)

What happens with Rails ends and our custom business logic begins? Many of us begin writing "service objects", but what exactly is a service object? How do we break down logic within the service object? What happens when a step fails? In this talk, we'll go over some of the most common approaches to answering these questions. We'll survey options to handle errors, reuse code, organize our directories, and even OO vs functional patterns. There isn't a perfect pattern, but by the end, we'll be much more aware of the tradeoffs between them.

> Riaz Virani has been building software since 2010. Currently, he serves at the CTO and Lead Developer at Load Up Technologies in the Atlanta area. While Ruby is his original love, the exciting developments in JavaScript always beckon his curiosity. Riaz is also an avid movie and history buff. You can read more of his musings at pennyforyourcode.com

### [Accessibility is a Requirement](https://www.youtube.com/watch?v=BF3D_IqOknk&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=63)

Accessible web applications reach wider audiences, ensure businesses are in compliance with the law, and, most importantly, remove barriers for the one in seven worldwide living with a permanent disability. But limited time, lack of knowledge, and even good intentions get in the way of building them.

Come hear my personal journey toward accessibility awareness. You will learn what accessibility on the web means, how to improve the accessibility of your applications today, and how to encourage an environment where accessibility is seen as a requirement, not simply a feature.

> Ryan Boone. I’m a real-life human front-end developer and designer based in Fort Worth, TX with a passion for web technologies, inclusivity, and Texas BBQ. I currently help make the space that comes from The Container Store.

### [You Are Your Own Worst Critic](https://www.youtube.com/watch?v=9hd4_X7urZ0&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=64)

Advancing through one's career can be challenging. As we experience setbacks, impostor syndrome, and uncertainty at various points of our career, we may develop some habits which, when taken too far, could see us sabotaging our own progress. You are your own worst critic.

Despite my own experience with anxiety, a bullying internal critic, and “self-deprecating humour”, I'm now a senior engineer and I've noticed these habits in people I mentor. I hope to help you identify signs of these bad habits in yourself and others, and to talk about what has helped me work through it.

> Ryan Brushett. Ryan is a senior production engineer on the Ruby Infrastructure team at Shopify where he spends his time working on type checking for Ruby. Ryan has been fortunate enough to work with (and mentor!) many talented people since joining the company in 2016 and he is passionate about sharing what he learns with others. Some of Ryan's hobbies include playing guitar, taking photos, and petting cats. He is from Newfoundland, Canada.

### [All you need to know to build Dynamic Forms (JS FREE)](https://www.youtube.com/watch?v=5peogeDq7R8&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=65)

Working with forms is pretty common in web apps, but this time my team was requested to give support for dynamic forms created by admins in an admin panel and used in several places (real story). There are many ways to implement it, but our goal was to build it in a way that felt natural in Rails.

This talk is for you if you’d like to learn how we used the ActiveModel's API together with the Form Objects pattern to support our dynamic forms feature, and the cherry on top is the usage of Hotwire to accomplish some more advanced features. And all of this is done without a single line of JS :)

> Santiago Bartesaghi. Santiago is a software engineer at Rootstrap. He is from Uruguay, a small country of about 3 million people. He has been developing Ruby/Rails apps for the last 6 years and he particularly enjoys work related to software architecture and design.

### [How To Get A Project Unstuck](https://www.youtube.com/watch?v=WdV_9by_JFs&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=66)

When an open source project has gotten stuck, how do you get it unstuck? Especially if you aren't already its maintainer? My teams have done this with several projects. A new contributor, who's never worked on a project before, can be the catalyst that revives a project or gets a long-delayed release out the door. I'll share a few case studies, principles, & gotchas.

More than developer time, coordination & leadership are a bottleneck in software sustainability. You'll come away from this talk with steps you can take, in the short and long runs, to address this for projects you care about.

> Sumana Harihareswara is an open source contributor and leader who has worked on PyPI, MediaWiki, autoconf, and other FLOSS projects. She has keynoted Open Source Bridge, LibrePlanet, and other tech conferences, and manages and maintains open source projects as Changeset Consulting. She's also a teacher and standup comedian, and has mentored new engineers and administered mentoring programs like Google Summer of Code.

### [Growing Software From Seed](https://www.youtube.com/watch?v=jiiNNtagLWI&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=67)

Pam Pierce writes, “Look at your garden every day. Study a plant or a square foot of ground until you’ve learned something new". In debugging my own garden, the practice of daily observation has revealed signals previously overlooked. This practice has followed me to the work of tending to our growing application.

This talk visits some familiar places, code that should work, or seems unnecessarily complicated, and digs deeper to find what we missed at first glance. Let’s explore how we can learn to hear all our application tells us and cultivate a methodical approach to these sticky places.

> Sweta Sanghavi is a Rails developer at Backerkit where she works on building products for backers, creators, and other BackerKats. She likes to think about the magic of pairing, retrospectives, and how to do things better. Iterating and growing with teams gives her almost as much joy as watching her seedlings emerge from the soil. Almost. She once put down scores of beets seeds from which emerged three beet seedlings. She has yet to harvest them.

### [Scaling Rails API to Write-Heavy Traffic](https://www.youtube.com/watch?v=aX2mDE_UMRA&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=68)

Tens of millions of people can download and play the same game thanks to mobile app distribution platforms. Highly scalable and reliable API backends are critical to offering a good game experience. Notable characteristics here is not only the magnitude of the traffic but also the ratio of write traffic. How do you serve millions of database transactions per minute with Rails?

The keyword to solve this issue is "multiple databases," especially sharding. From system architecture to coding guidelines, we'd like to share the practical techniques derived from our long-term experience.

> Takumasa Ochi is a Software Engineer and Product Manager on one of the Common Game Server teams at DeNA. He is passionate about developing backend systems for game apps. Scalability and reliability are the must-have features for today's game API backends.

### [What is developer empathy?](https://www.youtube.com/watch?v=y68t2M7_VVc&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=69)

Dev teams should employ empathetic patterns of behavior at all levels from junior developer to architect. Organizations can create the safety and security necessary to obtain a high functioning team environment that values courageous feedback if they simply have the language and tools to do so. How can leadership provide a framework for equitable practices and empathetic systems that promotes learning fluency across the team?

I have ideas. Find out what I've learned through countless hours of mentorship, encouragement, and support both learning from and teaching others to code.

> Tim Tyrrell. Software Engineer | Instructor @Turing School of Software & Design 4 Steps to Answering Student Questions with Zest - Original Medium LinkedIn Previous Talk as a Student at Turing

### [The Curious Case of the Bad Clone](https://www.youtube.com/watch?v=ok45gtFuMO8&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=70)

On Sept 4th 2020, I got pinged on a revert PR to fix a 150% slowdown on the Shopify monolith. It was a two-line change reverting the addition of a Sorbet signature on a Shop method, implicating Sorbet as the suspect.

That was the start of a journey that took me through a deeper understanding of the Sorbet, Rails and Ruby codebases. The fix is in Ruby 3.0 and I can sleep better now.

This talk will take you on that journey with me. Along the way, you will find tools and tricks that you can use for debugging similar problems. We will also delve into some nuances of Ruby, which is always fun.

> Ufuk Kayserilioglu. Ufuk is the Production Engineering Manager of the Ruby Infrastructure team at Shopify and brings over 20 years of industry experience to the company for the adoption of better Ruby tooling and practices. He currently works remotely from Cyprus where he lives with his beloved wife and wonderful daughter.

### [The Cost of Data](https://www.youtube.com/watch?v=h7LFYeiCtYs&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=71)

The internet grows every day. Every second, one of us is making calls to an API, uploading some images, or streaming the latest video content. But what is the cost of all this?

Every day, a data center stores information on our behalf. As engineers, it's easy to focus on the code and forget the tangible impact of our work. This talk explores the physical reality of creating and storing data today, as well as the challenges and technological advancements currently being made in this part of the tech sector. Together, we'll see how our code affects the physical world, and what we can do about it.

> Vaidehi Joshi. Vaidehi is the Lead Software Engineer at Forem. She is the creator of basecs and baseds, two writing series exploring the fundamentals of computer science and distributed systems. She also co-hosts the Base.cs Podcast, and is a producer of the BaseCS and Byte Sized video series.

### [Frontendless Rails frontend](https://www.youtube.com/watch?v=sIxvxp7E0xg&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=72)

Everything is cyclical, and web development is not an exception: ten years ago, we enjoyed developing Rails apps using HTML forms, a bit of AJAX, and jQuery—our productivity had no end! As interfaces gradually became more sophisticated, the "classic" approach began to give way to frontend frameworks, pushing Ruby into an API provider's role.

The situation started to change; the "new wave" is coming, and ViewComponent, StimulusReflex, and Hotwire are riding the crest.

In this talk, I'd like to demonstrate how we can develop modern "frontend" applications in the New Rails Way.

> Vladimir Dementyev. Vladimir is a mathematician who found his happiness in programming Ruby and Erlang, contributing to open source and being an Evil Martian. Author of AnyCable, TestProf, ActionPolicy and many yet unknown ukulele melodies.

### [What the fork()?](https://www.youtube.com/watch?v=4crIuSj-irQ&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=74)

How does Spring boot your Rails app instantly, or Puma route requests across many processes? How can you fine-tune your app for memory efficiency, or simply run Ruby code in parallel? Find out with a deep dive on that staple Unix utensil, the fork() system call!

After an operating systems primer on children, zombies, processes and pipes, we'll dig into how exactly Spring and Puma use fork() to power Rails in development and production. We'll finish by sampling techniques for measuring and maximizing copy-on-write efficiency, including a new trick that can reduce memory usage up to 80%.

> Will Jordan. Will is a software engineer at Code.org, a nonprofit dedicated to expanding access to computer science in schools and increasing participation by women and underrepresented minorities, where he has been building and scaling their Rails-powered learning platform since 2014.

### [Talmudic Gems For Rails Developers](https://www.youtube.com/watch?v=d08GFQDT824&list=PLbHJudTY1K0c8N1-PPyiQxlHNzJIzyJv6&index=75)

Am I my colleague’s keeper? To what extent are we responsible for the consequences of our code?

More than two thousand years ago conversations on central questions of human ethics were enshrined in one of the primary ancient wisdom texts, the Talmud.

Now, as the tech industry is beginning to wake up to the idea that we can not separate our work from its ethical and moral ramifications these questions take on a new urgency.

In this talk, we will delve into questions of our responsibility to our teammates, to our code, and to the world through both the ancient texts and modern examples.

> Yechiel Kalmenson. Yechiel Kalmenson (AKA Rabbi On Rails) is an ordained rabbi and an accomplished web developer. He lives in New Jersey with his family, where he tries to balance his passions for programming, teaching, and flying.

## Workshops

### [Storytelling for Tech People](https://www.youtube.com/watch?v=-pA2PlZ1WJk&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=4)

Remember the last conference talk that put you to sleep? It probably had a really catchy title, too. It's time to change that standard. It's time to learn how to turn our technical content into a beautiful story.

In this workshop you'll learn how to think differently about your topic; how to craft a story that will capture and impress your audience.

> Avital Tzubeli is a passionate storyteller and tech storytelling trainer. She believes that any boring content can be turned into a magical fairytale. Avital began telling stories in NYC, and has since spoken on stages in Stockholm, Dublin, Tokyo, Brussels, and throughout the USA. A software engineer turned developer advocate, now at Vonage, Avital loves empowering developers to build epic stories and share them with the world.

### [Debugging Your Brain](https://www.youtube.com/watch?v=hpy5M1BNg7o&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=9)

Sometimes your mind distorts reality, gets frustrated with shortcomings, or spirals out of control. Learn how to debug these by using research-backed psychology techniques.

> Casey Watts. Casey studied neurobiology at Yale University, and he is a co-author on several neurobiology papers. He has also worked in software development for 10 years, including at Heroku. Casey can play ten musical instruments, and he owns one in every color of the rainbow, most recently a white accordion.

### [The Secrets of Successful Mentors](https://www.youtube.com/watch?v=bGIqJ77-5oQ&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=3)

How do the best mentors operate? What makes them so effective? In this workshop, we will explore some counter-intuitive techniques that great mentors use in helping their apprentices learn fast and achieve extraordinary results. Learn how to give just the right learning challenge and just the right time and how to give feedback in a way that will actually be heard!

We will explore how mentoring is fundamentally different than teaching. We will also look at some psychology and brain science to understand what makes learners tick and how they respond when we give them feedback.

> Doug Bradbury. Doug recently left 8th Light, where he started the mentorship program in 2008, to start One World Coders, an offshore software development consultancy that aims to take mentorship across geographic and cultural borders to build affordable, world-class software teams. Doug has personally mentored more than 40 Software Crafters and writes and speaks about mentorship to companies and groups across the globe. He is also the Director of Engineering at Dade Systems, a B2B Rails product.

### [Upgrading Rails: The Dual-Boot Way](https://www.youtube.com/watch?v=Sid39aN_SKk&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz)

Upgrading Rails is easy, right? Sure, as long as you are upgrading your patch version. A Rails upgrade project for a majestic monolith is not a trivial project. While upgrades have become easier with every new Rails version, your application has only become more complicated with every new dependency.

In this workshop you will learn a proven Rails upgrade process which relies on "dual booting" to quickly iterate and upgrade! You will leave this workshop with a new set of tools that will make your next upgrade project less daunting.

> Ernesto Tagwerker. Ernesto is the Founder of FastRuby.io & OmbuLabs, a small software development shop dedicated to building lean code and upgrading your Ruby on Rails applications. When he is not mindlessly playing chess online, he likes to maintain a few Ruby gems including skunk and bundler-leak. He is passionate about spending time with his family, writing less code, contributing to open source, and eating empanadas.

> Luciano Becerra. Luciano is a Senior Software Engineer at FastRuby.io & OmbuLabs. He has many years of experience working with Rails. He often writes articles for the FastRuby.io blog and works on Open Source projects as a way to give back to the community. He has been coach and organizer at multiple Rails Girls events. When he's not in front of a computer, he's probably outdoors taking photos with his camera.

> Cleiviane Costa. Cleiviane is a Brazilian Software Engineer who works at FastRuby.io & OmbuLabs. She's passionate about entrepreneurship and technology. She likes to think outside the box and propose new ideas. She also dedicates part of her time to diversity initiatives.

### [Believe in Rails Magic? Unlock the Powers of Rails](https://www.youtube.com/watch?v=-7JizhZs4jA&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=11)

Poof! Before your eyes is a full-stack exercise tracking application utilizing rails forms. How did it get there? During this workshop, we're going to help you understand Rails magic! This workshop is perfect for Rails beginners who are looking to get a better understanding of the magic happening inside of Rails. We're going to teach how to build a full-stack rails exercise tracking application that allows the user to retrieve information from the database as well as add content to the database. You will also learn about mapping CRUD actions to HTTP verbs to RESTful routes. As well as following developer flow to implement routes, controller methods, and views for RESTful routes. Then, at the end of the workshop, everything will come together, and you will understand some of the amazing magic hidden inside of Rails!

> Lea Ann Bradford. Lea Ann is a Senior Software Developer for Notch8, a web and mobile development agency based in San Diego and is a graduate of LEARN Academy. She discovered coding as a stay-at-home mom, and jumped head first into the world of Rails development when she decided to re-enter the workforce. She is a life-long learner who loves to share her passion for coding with others, as well as support beginners on their journey into and through the tech world.

> Matthieu Tripoli. Matthieu is a developer from RealPage by LeaseLabs, crafting real estate and property management software for multifamily, commercial, and more. Starting with websites when they were table based, Matthieu continued dabbling on/off while pursuing other interests, before returning to code full-time in 2017. After learning Ruby and Rails from Learn Academy, he has continued growing while working with a variety of languages and frameworks, and sharing his knowledge and enthusiasm.

### [Deploying your Rails Application to Kubernetes](https://www.youtube.com/watch?v=lelyJhuj1g8&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=6)

Kubernetes has a lot of DevOps mindshare and is how shops like GitHub and Shopify are deploying their apps. But, what is Kubernetes? What does it mean for deploying your application? Do you need it?

In this workshop, we'll answer by migrating a small Rails application to Kubernetes. We'll build up the deployment tooling necessary to stand the application up on a small Kubernetes cluster.

We'll also explore the core concepts and considerations of adding Kubernetes to your deployment pipeline, including Kubernetes operations, preparing for ephemeral infrastructure, data storage, and more.

> Nathan L. Walls is a developer who works with and trains up software teams to test well, refactor to clarify intent and improve understanding, separate concerns, and stay adaptive with an emphasis on learning, respect and empathy. Nathan's also a photographer, kung fu student, qigong practitioner, day hiker and cat herder. He writes at <http://wallscorp.us>.

> Alex Panait has been writing production-ready software for more than twenty years. He has a Masters in Computer Science and has worked in many technical roles across several industries. Outside of his own development work, he enjoys helping other developers improve their coding skills.

### [Hotwire: HTML over The Wire](https://www.youtube.com/watch?v=AdktV7r2BQk&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=7)

Last December, the team behind Basecamp and Hey released Hotwire, a library for managing client side interactions by sending HTML to the client. Hotwire bundles the Stimulus JavaScript library with an expanded Turbo library which makes a wide range of client side interactions possible without writing any custom JavaScript. In this workshop, attendees will see first-hand how powerful the new library is by adding powerful interactions to a basic Rails view.

> Noel Rappin is an Engineering Manager at Root Insurance. Noel has authored multiple technical books, including "Modern Front End Development For Rails" and "Rails 5 Test Prescriptions". He also hosted the podcast Tech Done Right. Follow Noel on Twitter @noelrap, and online at <http://www.noelrappin.com>.

### [OAuth 2.0 Deconstructed](https://www.youtube.com/watch?v=M7DkOLw1TtU&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=5)

OAuth is an authorization standard that is both powerful and daunting to learn. Higher level libraries like OmniAuth can ease the process of implementing OAuth, but it can be difficult to debug or customize the code without first understanding OAuth at a lower level.

This workshop breaks down the OAuth standard from the very basic principles, covering the terminology in an easy to digest fashion. It goes over step-by-step code examples to implement OAuth from scratch for several providers, so you get the repetition necessary to work with OAuth on your own at any level of abstraction.

> Peter Jang is the Dean of Instruction at Actualize, where he designs the web development curriculum and teaches live classes at the Actualize Chicago main campus. He has been programming professionally since 2002 and has been a classroom instructor since 2008. His passion is to blend his teaching and programming expertise to create the best technology educational resources available.

### [Effective Resumes for Tech](https://www.youtube.com/watch?v=QtopfnCqq7w&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=8)

Transitioning into tech from another industry can sometimes feel like you're starting all over, but it doesn't have to be that way! Come armed with your resume, your cover letter, and a job posting you're interested in. We'll work through reframing your application materials to showcase the ways in which your previous experience is an asset to employers.

> Rachel Bussert is the Director of Student Services at Epicodus, leading the career services team for students looking to break into tech. Outside of work, she is an avid PC and tabletop gamer, a comic collector, and a frequent herder of cats.

### [Writing Better Forms](https://www.youtube.com/watch?v=Wyyy2D7tIIk&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=10)

Forms are the unsung hero of a web app. Without them, most of our sites wouldn't have any data or even users. But we don't talk about forms that much, other than to say that building forms is hard. We want our forms to look nice and be useful, but sometimes that feels impossible. Join me for a refresher course on forms. We'll walk through creating three types of forms, from basic to advanced. Along the way I'll teach you some tips and tricks to create forms that delight users without frustrating your developers. And it's all vanilla Rails and JS as well - no extra DSL or libraries required.

> Rachel Green is a developer based in Houston, Texas with experience in building B2B, e-commerce, and enterprise applications. She is also a regular contributor to open-source projects and co-organizer for tech related meetups. Outside of tech, Rachel is also involved with civic engagement and advocacy efforts and is passionate about the potential for tech to do good for others. When it's time to relax, Rachel can be found curled up with a good book while baking bread.

### [Intro to Test Driven Development: How to Safely Make Changes](https://www.youtube.com/watch?v=pdm7vXPBzJA&list=PLbHJudTY1K0cawo3AfY5Bp6oUPH65MnKz&index=2)

Even small changes to large codebases can make everything come crashing down. When you make a change to an already working application, how are you to be sure everything is still working correctly? With Test Driven Development!

In this workshop, we will take a dive into the capybara gem to take the role of every user under the sun you can think of, and replicate their behavior. We will first cover vocabulary and create a small full-stack application, and then go into how to incorporate tests, to ensure our application is working the way we intend it to. Stretch goals include covering modularizat

> Zack Pieper. Zack has been an instructor at Coding Dojo since 2019, teaching the fundamentals of languages, including Rails, to new faces to programming. When not teaching or coding, Zack can be found eating extra toasty Cheez-Its while playing a new board game, exploring baking, or cracking a code in an escape room.
