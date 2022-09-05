# php md5

Are you still using MD5 in PHP!?

## Notes

[MD5](https://en.wikipedia.org/wiki/MD5) is a cryptographically broken but still used for hashing.

PHP has an [md5](https://www.php.net/manual/en/function.md5.php) string function

## Example

See [to_md5.php](./to_md5.php) - a simple wrapper for the md5 function:

  $ php to_md5.php QNKCDZO
  QNKCDZO as md5: 0e830400451993494058024219903391

## MD5 Comparisons

Always use triple equals `===`. Why? ...

    $ php example.php
    240610708 as md5: 0e462097431906509019562988736854
    QNKCDZO as md5: 0e830400451993494058024219903391
    md5(240610708) == md5(QNKCDZO) : true (!!!)
      -> This comparison is true because both md5() hashes start '0e' so PHP type juggling understands these strings to be scientific notation.  By definition, zero raised to any power is zero.
    md5(240610708) === md5(QNKCDZO) : false
      -> always use the triple equals === for comparing stirng values to avoid all the quirks and pitfalls.

## Credits and References

* [MD5](https://en.wikipedia.org/wiki/MD5) wikipedia
* [md5](https://www.php.net/manual/en/function.md5.php) - PHP function reference
