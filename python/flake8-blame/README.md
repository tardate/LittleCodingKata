# flake8-blame

Who busted Python style-guide rules?

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

Personally, I find [flake8](http://flake8.pycqa.org/en/latest/) the most pragmatic
style-guide check for Python.

In Python projects, I'll often also run [pylint](https://www.pylint.org/)
as part of CI, but without excessive effort to customise the rules,
it is prone to throw lot's of what we'd call "false positives".
flake8 is much easier to tame.

Now when flake8 is reporting errors it is often useful to know
who/what commits/what stories introduced the error.
AFAIK, flake8 doesn't help you do that directly.
But here's a one-liner that will take the flake8 output and `git blame` the offending lines:

    flake8 | awk -F ':' '{print $2 "," $2, $1}' | xargs -n2 git blame -f -L

This is available in the shell script [flake8-blame.sh](./flake8-blame.sh)

## Example

Say you have a project that is currently reporting a few errors:

    $ flake8 .
    ./api/tests/test_one.py:7:1: E303 too many blank lines (3)
    ./api/tests/test_one.py:11:58: E251 unexpected spaces around keyword / parameter equals
    ./api/tests/test_two.py:38:39: E225 missing whitespace around operator


Then the one-liner can help pin-down the commit and commiter:

    $ flake8 | awk -F ':' '{print $2 "," $2, $1}' | xargs -n2 git blame -f -L
    f6aeee433a snowflake/api/tests/test_one.py (Paul Gallagher 2018-10-03 18:19:08 +0800 7) class TestSomething(ScenarioTestBase):
    f9cb75650b snowflake/api/tests/test_one.py (Paul Gallagher 2018-10-03 19:39:01 +0800 11)         self.some_function(max_devices= 2)
    f9cb75650b snowflake/api/tests/test_two.py (Paul Gallagher 2018-10-03 19:39:01 +0800 38)         self.some_attribute =None


Note: this may not be exact as the way that errors are reporting may not identify the correct line to blame.
For example, `E303 too many blank lines` in the example above says the error occurred on the first line **after**
the blank lines, so the commit details don't actually identify the erroneous commit correctly.

## Credits and References
* [xargs man page](https://linux.die.net/man/1/xargs)
* [flake8](http://flake8.pycqa.org/en/latest/) - Python Style Guide Enforcement
* [pylint](https://www.pylint.org/)
