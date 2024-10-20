# #069 Modules Start From Here
*or*
**why not to put an __init__.py in your top level folder**

So this got my attention after a code refactoring left some actual code and its accompanying tests
disagreeing on how to reference modules.

We were using [nose](http://nose.readthedocs.org/en/latest/),
and all the tests referenced absolute imports based on the containing folder.
But the code didn't. And because the code didn't attempt to make any references
to sistem or parent modules, it all *seemed* to work.

Well kinda. It was a hack and a trap.

And after [finding this SO question](http://stackoverflow.com/questions/6670275/python-imports-for-tests-using-nose-what-is-best-practice-for-imports-of-modul), it was obvious the problem was simply an extraneous `__init__.py` in the top level folder.


## How To Do It

This demonstrates a simple modules structure with imports up and down.
The code and tests all agree on how to reference modules.
And there is no fiddling of the PYTHONPATH required.

Note that `sys.path` resolves identically.

```
$ cd how_to_do_it/
$ python hello.py
Current top of sys.path: /[...]/LittleCodingKata/python/top_level_imports/how_to_do_it
Hello
$ nosetests --nocapture
Current top of sys.path: /[...]/LittleCodingKata/python/top_level_imports/how_to_do_it
..
----------------------------------------------------------------------
Ran 2 tests in 0.004s

OK

```

## Not How To Do It

Exactly the same code, but there's a `__init__.py` in the top level folder.
Code runs, but nose can't find the modules.

```
$ cd not_how_to_do_it
$ python hello.py
Hello
$ nosetests --nocapture
EE
======================================================================
ERROR: Failure: ImportError (No module named constants)
----------------------------------------------------------------------
Traceback (most recent call last):
  [...] not_how_to_do_it/tests/test_hello.py", line 2, in <module>
    import constants
ImportError: No module named constants

======================================================================
ERROR: Failure: ImportError (No module named constants)
----------------------------------------------------------------------
Traceback (most recent call last):
  [...] not_how_to_do_it/tests/test_util.py", line 2, in <module>
    import constants
ImportError: No module named constants

----------------------------------------------------------------------
Ran 2 tests in 0.001s

FAILED (errors=2)
```

## Not How To Do It (Hacked)

So if you start off with `./not_how_to_do_it`, it is possible to hack the imports
in tests to make it look like it works. But it's a fake, as it is really
running with different `sys.path` in each case. And referencing modules upwards
is just impossible to make work in both cases.

So don't do this;-)

```
$ cd not_how_to_do_it_hax
$ python hello.py
Current top of sys.path: /[...]/LittleCodingKata/python/top_level_imports/not_how_to_do_it_hax
Hello
$ nosetests
..
----------------------------------------------------------------------
Ran 2 tests in 0.001s

OK
$ nosetests --nocapture
Current top of sys.path: /[...]/LittleCodingKata/python/top_level_imports
..
----------------------------------------------------------------------
Ran 2 tests in 0.001s

OK
```


## Credits and References
* [Python imports for tests using nose - what is best practice for imports of modules above current package](http://stackoverflow.com/questions/6670275/python-imports-for-tests-using-nose-what-is-best-practice-for-imports-of-modul)
* [Importing your own modules and setting the PYTHONPATH](https://users-cs.au.dk/chili/PBI/pythonpath.html)
