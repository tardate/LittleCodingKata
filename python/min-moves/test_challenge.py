#! /usr/bin/env python
import unittest
from challenge import minMoves


class MinMovesTests(unittest.TestCase):
    def test_example1(self):
        self.assertEqual(10, minMoves("8051", "1199"))

    def test_example2(self):
        self.assertEqual(15, minMoves("000", "555"))

    def test_example3(self):
        self.assertEqual(4, minMoves("109", "990"))


if __name__ == '__main__':
    unittest.main()
