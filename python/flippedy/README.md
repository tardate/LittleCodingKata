# #409 flippedy

Using python to count vowels and flip words; cassidoo's interview question of the week (2026-01-26).

## Notes

The [interview question of the week (2026-01-26)](https://buttondown.com/cassidoo/archive/happiness-is-a-choice-that-requires-effort-at/):

> You are given a string consisting of lowercase words, each separated by a single space. Determine how many vowels appear in the first word. Then, reverse each following word that has the same vowel count.
>
> Examples:
>
> ```ts
> flippedy("cat and mice")
> > "cat dna mice"
>
> flippedy("banana healthy")
> > "banana healthy"
> ```

### Thinking about the Problem

Seems pretty straight-forward: count the vowels in each word:

* vowels: aeiou
* don't forget: case-insensitive

There is a typical requirement ambiguity however: "Determine how many vowels appear in the first word" could mean two different things:

* count the number of characters that are vowels i.e "Wheee!" == 3
* OR count how many vowels appear in the word i.e "Wheee!" == 1

The examples don't answer this definitively. I'll go with the first interpretation

### A First Go

Breaking the problem down into 2 simple parts:

* count vowels in a word
* iterate the words, flipping as required

For a first go, I'll just used list comprehensions:

```python
def vowel_count(word):
    vowels = 'aeiouAEIOU'
    return sum(1 for char in word if char in vowels)

def flippedy(input):
    words = input.split()
    first_word = words.pop(0)
    target_count = vowel_count(first_word)
    flipped_words = [word[::-1] if vowel_count(word) == target_count else word for word in words]
    return ' '.join([first_word] + flipped_words)
```

The expression `word[::-1]` is a neat way of reversing a string in python.

And that works nicely:

```sh
$ ./challenge.py "cat and mice"
cat dna mice
$ ./challenge.py "banana healthy"
banana healthy
```

### Refining the Code

The list comprehension is a bit ungainly for counting vowels. How about a regex approach instead:

```python
def vowel_count(word):
    return len(re.findall(r'[aeiou]', word, re.IGNORECASE))
```

### Tests

I've setup some validation in [test_challenge.py](./test_challenge.py):

```sh
$ ./test_challenge.py
....
----------------------------------------------------------------------
Ran 4 tests in 0.000s

OK
```

### Example Code

Final code is in [challenge.py](./challenge.py):

```python
#! /usr/bin/env python
from sys import argv
import re

def vowel_count(word):
    return len(re.findall(r'[aeiou]', word, re.IGNORECASE))

def flippedy(input):
    words = input.split()
    first_word = words.pop(0)
    target_count = vowel_count(first_word)
    flipped_words = [word[::-1] if vowel_count(word) == target_count else word for word in words]
    flipped_words.insert(0, first_word)
    return ' '.join(flipped_words)

if __name__ == '__main__':
    if len(argv) == 2:
        print(flippedy(argv[1]))
    else:
        print("Usage: challenge.py '<string>'")
```

## Credits and References

* [cassidoo's interview question of the week (2026-01-26)](https://buttondown.com/cassidoo/archive/happiness-is-a-choice-that-requires-effort-at/)
