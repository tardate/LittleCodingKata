#! /usr/bin/env python
import unittest
from challenge import firstFrost


class FirstFrostTests(unittest.TestCase):
    def test_example1(self):
        self.assertEqual([3, 2, 1, 2, 1, 0], firstFrost([70, 68, 72, 60, 65, 55], 5))

    def test_example2(self):
        self.assertEqual([0, 0, 0], firstFrost([50, 49, 48], 5))

    def test_example3(self):
        self.assertEqual([1, 2, 1, 0], firstFrost([40, 30, 45, 20], 10))


if __name__ == '__main__':
    unittest.main()
