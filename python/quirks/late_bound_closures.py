#! /usr/bin/env python
#
# See:
# http://docs.python-guide.org/en/latest/writing/gotchas/
#
import unittest


class LateBoundClosureTests(unittest.TestCase):

    def quirky_create_multipliers(self):
        return [lambda x : i * x for i in range(5)]

    def create_multipliers(self):
        return [lambda x, i=i : i * x for i in range(5)]

    def testQuirky(self):
        result = []
        for multiplier in self.quirky_create_multipliers():
            result.append(multiplier(2))
        self.assertEqual(result, [8, 8, 8, 8, 8])

    def testNonQuirky(self):
        result = []
        for multiplier in self.create_multipliers():
            result.append(multiplier(2))
        self.assertEqual(result, [0, 2, 4, 6, 8])


if __name__ == '__main__':
    unittest.main()
