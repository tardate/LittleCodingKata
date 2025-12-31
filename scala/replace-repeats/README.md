# #xxx replaceRepeats

Using Scala to replace repeating digits in a number; cassidoo's interview question of the week (2025-12-29).

## Notes

The [interview question of the week (2025-12-29)](https://buttondown.com/cassidoo/archive/the-beginning-is-the-word-and-the-end-is-silence/)
asks us to replace repeating digits in a number:

> Given a string that contains only digits from 0 to 9 and a number n, replace each consecutive run of n with its length.
>
> Examples:
>
> ```ts
> > replaceRepeats('1234500362000440', 0)
> > 1234523623441
>
> > replaceRepeats('000000000000', 0)
> > 12
>
> > replaceRepeats('123456789', 1)
> > 123456789
> ```

## Thinking about the Problem

The first challenge with this problem is correctly understanding what is being asked! Strings, digits, numbers, length - all a bit ambiguous at first glance.

Breaking it down:

* with have a string containing only digits from "0" to "9"
* we are given a number `n` from 0 to 9
* we search for consecutive runs of `n` (as a digit) appearing in the source string
    * and replace the consecutive run with a string representing the length of the consecutive run (in decimal)

Algorithmically, two approaches leap to mind:

* simple iteration over the source string
* or perhaps pattern matching using regular expressions or even sed/awk

## A first approach

I'll first do a simple iteration. To make it a little more challenging, I'm using Scala - a language I've not really used in anger before.

In the following implementation:

* The `foldLeft` method builds a list of `(character, runLength)` pairs.
* It prepends (`::`) the elements, so the list needs to be `reversed` before generating the resulting string
    * Why prepend? Prepend is cheap, appending is not
* Then `map` the list:
    * If the character matches n, replace the run with its length.
    * Otherwise, expand the character back to its original count.

```scala
def replaceRepeats(s: String, n: Int): String = {
  val target = n.toString.head

  s.foldLeft(List.empty[(Char, Int)]) {
    case ((c, count) :: rest, ch) if ch == c =>
      (c, count + 1) :: rest
    case (acc, ch) =>
      (ch, 1) :: acc
  }.reverse.map {
    case (c, count) if c == target =>
      count.toString
    case (c, count) =>
      c.toString * count
  }
  .mkString
}
```

Running the program:

```sh
$ scala run challenge.scala
Compiling project (Scala 3.7.4, JVM (17))
Compiled project (Scala 3.7.4, JVM (17))
replaceRepeats("1234500362000440", 0): 1234523623441 (√CORRECT)
replaceRepeats("000000000000", 0): 12 (√CORRECT)
replaceRepeats("123456789", 1): 123456789 (√CORRECT)
```

Looking good!

### Example Code

Final code is in [challenge.scala](./challenge.scala):

```scala
//> using scala 3.7.4

def replaceRepeats(s: String, n: Int): String = {
  val target = n.toString.head

  s.foldLeft(List.empty[(Char, Int)]) {
    case ((c, count) :: rest, ch) if ch == c =>
      (c, count + 1) :: rest
    case (acc, ch) =>
      (ch, 1) :: acc
  }.reverse.map {
    case (c, count) if c == target =>
      count.toString
    case (c, count) =>
      c.toString * count
  }
  .mkString
}


def trial(s: String, n: Int, expected: String) = {
  val result = replaceRepeats(s, n)
  print("replaceRepeats(\"" + s + "\", " + n + "): " + result + " ")
  if(result == expected) {
    println("(√CORRECT)")
  } else {
    println("(WRONG, should be " + expected + ")")
  }
}


@main
def hello(): Unit =
  trial("1234500362000440", 0, "1234523623441")
  trial("000000000000", 0, "12")
  trial("123456789", 1, "123456789")
```

## Credits and References

* [cassidoo's interview question of the week (2025-12-29)](https://buttondown.com/cassidoo/archive/the-beginning-is-the-word-and-the-end-is-silence/)
* [LCK#395 About Scala](../about/)
* [foldLeft](https://www.scala-lang.org/api/2.13.3/scala/collection/StringOps.html#foldLeft[B](z:B)(op:(B,Char)=%3EB):B)
