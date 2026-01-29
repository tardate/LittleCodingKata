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
