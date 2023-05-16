#! /usr/bin/env python
#
import unittest
from lpickr import pick


class LpickrTests(unittest.TestCase):

    def test_returns_expected_number_of_numbers(self):
        self.assertEqual(1, len(pick(1, 40)))
        self.assertEqual(6, len(pick(6, 40)))
        self.assertEqual(12, len(pick(12, 40)))

    def test_returns_all_numbers_within_range(self):
        for _ in range(100):
            result = pick(1, 10)
            self.assertEqual(1, len(result))
            self.assertTrue(1 <= result[0] <= 10)

    def test_fails_if_ask_for_more_numbers_than_available(self):
        self.assertRaises(Exception, lambda: pick(6, 5))

    def test_empty_if_ask_for_zero(self):
        self.assertEqual(0, len(pick(0, 0)))


if __name__ == '__main__':
    unittest.main()
