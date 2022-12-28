# The Pocket Guide to Debugging

Book notes - [The Pocket Guide to Debugging](https://wizardzines.com/zines/debugging-guide/) by Julia Evans

## Notes

The Pocket Guide to Debugging is pretty much everything I wish I'd known when I first started writing serious software .. or software seriously.

The zine format is perfect for this kind of guide:

* For those new to software development, it is concise, clear and complete. And of course very approachable. In a short read, newcomers can probably absorb a some key ideas that might otherwise take years to learn
* For experienced developers, it is an easily digested and fun little refresher. There are probably techniques here that we haven't though about consciously for years. The act of remembering can be powerful reinforcement.
* In the midst of a crisis. I can easily imaging pulling out this guide to use as a thinking tool when all else has failed.

The book doesn't get bogged down in teaching specific tools, as it is focused more on sharing practical techniques and methods for finding and correctly identifying bugs.

The book largely assume the context of a single code base, so it does not try to cover for example special considerations for distributed systems. It also assumes that a software bug is actually involved, so it does not try to provide any special guidance for when a root cause may be traced to non-software aspects such as hardware, process, or business rules/policy.

However this does not detract from the core message: the problem-solving mindset that is the most important factor in being able to successfully fix bugs of all kinds.

Once found, most bugs are relatively easy to fix.
This is even true of the case cited by Grace Hopper in 1947 that popularised the term "bug" for computer issues.
[Operators traced an error in the Harvard Mark II to a moth trapped in a relay](https://en.wikipedia.org/wiki/Software_bug#History) - a gnarly problem, but with a simple fix!

I am pretty sure that even in a future when AI is writing all our software, these are the kind skills we will still need when they call in the expensive wetware consultants to "debug" the AI-generated disasters!

Oh, and the book makes fixing bugs sound like a fun and rewarding way to spend your time. Which it can be, even if sometimes only in retrospect with rose-tinted glasses;-)

### Table of Contents

The outline:

* a debugging manifesto
* first steps
    * preserve the crime scene
    * read the error message.
    * reread the error message
    * reproduce the bug
    * Inspect unreproducible bugs.
    * identify one small question.
    * retrace the code's steps.
    * write a failing test
* get organized
    * brainstorm some suspects
    * role things out
    * keep a logbook
    * draw a diagram
* investigate
    * add lots of print statements
    * use a debugger
    * jump into a REPL
    * find a version that works
    * look at recent changes
    * sprinkle assertions everywhere
    * comment out code
    * analyze the logs
* research
    * read the docs
    * find the type of bug
    * learn one small thing
    * read the library's code
    * find a new source of info
* simplify
    * write a tiny program
    * one thing at a time
    * tidy up your code
    * delete the buggy code
    * reduce randomness
* get unstuck
    * take a break
    * investigate the bug together
    * timebox your investigation
    * write a message asking for help
    * explain the bug out loud
    * make sure your code is running
    * do the annoying thing
* improve your toolkit
    * tryout a new took
    * types of debugging tools
    * shorten your feedback loop
    * add pretty printing
    * colours, graphs, and sounds
* after it's fixed
    * do a victory
    * tell a friend what you learned
    * find related bugs
    * add a comment
    * document your quest

### Some Additional Thoughts

Some additional thoughts that came to mind as I read through the book:

Re: manifesto: there's always a reason

* symptoms can often distract from finding the underlying cause.
* I found this to be especially common when doing log/error analysis, as it will often surface multiple possible errors and issues
    * the temptation is to fixate on and fix the first problem encountered without fully understanding how or why it is the reason behind the bug being investigated
* [five whys](https://kanbanize.com/lean-management/improvement/5-whys-analysis-tool), [hypothesis-based investigation](https://en.wikipedia.org/wiki/Hypothesis) and [Ishikawa diagrams](https://en.wikipedia.org/wiki/Ishikawa_diagram) can help sift symptoms from root causes

Re: get unstuck:

* "if you can't ship a fix, ship a canary" (better instrumentation)

Re: improve your toolkit - types of debugging tools:

* logging and runtime instrumentation tools: airbrake, sentry, riemann, newrelic, syslog, cloudwatch

## Credits and References

* [The Pocket Guide to Debugging](https://wizardzines.com/zines/debugging-guide/)
* [The Pocket Guide to Debugging](https://www.goodreads.com/book/show/75355942-the-pocket-guide-to-debugging) - goodreads
* [five whys](https://kanbanize.com/lean-management/improvement/5-whys-analysis-tool)
* [hypothesis-based investigation](https://en.wikipedia.org/wiki/Hypothesis)
* [Ishikawa diagrams](https://en.wikipedia.org/wiki/Ishikawa_diagram)
