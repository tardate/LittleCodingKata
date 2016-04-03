#! /usr/bin/env python
#
# See:
# http://docs.python-guide.org/en/latest/writing/gotchas/#late-binding-closures
#
import unittest


class LateBoundClosureTests(unittest.TestCase):

    def create_multipliers_quirky(self):
        return [lambda x : i * x for i in range(5)]

    def create_multipliers_hacked(self):
        return [lambda x, i=i : i * x for i in range(5)]

    def test_quirky(self):
        result = []
        for multiplier in self.create_multipliers_quirky():
            result.append(multiplier(2))
        self.assertEqual(result, [8, 8, 8, 8, 8])  # correct, but 'unexpected'!

    def test_hacked_fix(self):
        result = []
        for multiplier in self.create_multipliers_hacked():
            result.append(multiplier(2))
        self.assertEqual(result, [0, 2, 4, 6, 8])


if __name__ == '__main__':
    unittest.main()
