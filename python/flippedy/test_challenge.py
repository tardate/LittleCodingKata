#! /usr/bin/env python
import unittest
from challenge import flippedy
from challenge import vowel_count


class VowelCountTests(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(1, vowel_count('cat'))
        self.assertEqual(1, vowel_count('and'))
        self.assertEqual(2, vowel_count('mice'))

    def test_example2(self):
        self.assertEqual(3, vowel_count('banana'))
        self.assertEqual(2, vowel_count('healthy'))


class FlippedyTests(unittest.TestCase):

    def test_example1(self):
        self.assertEqual('cat dna mice', flippedy('cat and mice'))

    def test_example2(self):
        self.assertEqual('banana healthy', flippedy('banana healthy'))


if __name__ == '__main__':
    unittest.main()
