# #166 Proc v Lambda

Exploring differences and similarities between procs and lambdas in Ruby.

## Notes

Ruby gives you all these ways of creating closures: `Proc`, `proc`, `lambda` `->`.

TLDR:

* these are all basically the same, but with some subtle differences that one is best advised to avoid making code dependent upon.
* when in doubt, just use `lambda` (multi-line) or stabby `->` (single line).

### Language Feature Definitions

* [Proc](https://ruby-doc.org/core-2.7.0/Proc.html) - A Proc object is an encapsulation of a block of code, which can be stored in a local variable, passed to a method or another Proc, and can be called
* [proc](https://ruby-doc.org/core-2.7.0/Kernel.html#method-i-proc) - kernel method Equivalent to Proc.new.
* [lambda](https://ruby-doc.org/core-2.7.0/Kernel.html#method-i-lambda) - Equivalent to Proc.new, except the resulting Proc objects check the number of parameters passed when called.
* [->](https://ruby-doc.com/core/doc/syntax/literals_rdoc.html#label-Procs) - A proc can be created with `->` (it is in fact a lambda-style proc)

### Technical Differences

Procs and lambdas both return `Proc` objects, but they have different "lambda-ness"!!
The lambda-ness affects argument handling and the behavior of return and break.

    proc_handle = proc { puts "i'm a proc" }
    lambda_handle = lambda { puts "i'm a lambda-style proc" }
    assert_equal proc_handle.class, lambda_handle.class
    assert_equal false, proc_handle.lambda?
    assert_equal true, lambda_handle.lambda?

### Difference 1: arguments

Lambdas check the number of arguments, while procs do not

### Difference 2: return context

Procs return from the current method, while lambdas return from the lambda itself:

* `return` inside a lambda returns to the calling context where the lambda was executed
* `return` inside a proc return from the calling context where the proc was executed

NB: `break` has the same effect is applicable

### Best Practices in a Nutshell

[Stabby Lambda Definition with Parameters](https://rubystyle.guide/#stabby-lambda-with-args)
Use parens:

    l = ->(x, y) { something(x, y) }

[Stabby Lambda Definition without Parameters](https://rubystyle.guide/#stabby-lambda-no-args)
Don't use parens:

    l = -> { something }

[Multi-line Lambda Definition](https://rubystyle.guide/#lambda-multi-line)
Use `lambda` method instead of stabby lambda `->`:

    l = lambda do |a, b|
      tmp = a * 7
      tmp * b / 50
    end

[proc vs Proc.new](https://rubystyle.guide/#proc)
Prefer `proc` over `Proc.new`:

    p = proc { |n| puts n }

[Proc Call](https://rubystyle.guide/#proc-call)
Prefer proc.call() over proc[] or proc.() for both lambdas and procs.

    l = ->(v) { puts v }
    l.call(1)

## Example Code

The [examples.rb](./examples.rb) file wraps up demonstrations of all these features in a set of tests.
Not very exciting to run!

    $ ruby examples.rb
    Run options: --seed 46371

    # Running:

    ............

    Finished in 0.001421s, 8444.7566 runs/s, 16185.7834 assertions/s.

    12 runs, 23 assertions, 0 failures, 0 errors, 0 skips

## Credits and References

* [What's the difference between a proc and a lambda in Ruby?](https://stackoverflow.com/questions/1740046/whats-the-difference-between-a-proc-and-a-lambda-in-ruby)
* [proc vs Proc.new](https://rubystyle.guide/#proc)
* [Blocks, Procs & Lambdas](https://rubystyle.guide/#blocks-procs-lambdas) - rubystyle guide
