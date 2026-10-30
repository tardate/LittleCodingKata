#! /usr/bin/env python
import unittest
from challenge import challenge


class ChallengeTests(unittest.TestCase):
    def test_example1(self):
        self.assertEqual('expected', challenge('given'))


if __name__ == '__main__':
    unittest.main()
