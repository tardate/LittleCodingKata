#! /usr/bin/env python
import unittest
from random_mac import random_mac


class RandomMacTests(unittest.TestCase):

    def test_valid_mac_structure(self):
        mac = random_mac()
        self.assertRegexpMatches(mac, r'[\da-f]{2}-[\da-f]{2}-[\da-f]{2}-[\da-f]{2}')

    def test_no_two_tha_same(self):
        mac1 = random_mac()
        mac2 = random_mac()
        self.assertNotEqual(mac1, mac2)

    def test_default_OUI(self):
        mac = random_mac()
        self.assertEqual(mac[:8], '00-16-3e')

    def test_override_OUI(self):
        custom_oui = '11-22-33'
        mac = random_mac(custom_oui)
        self.assertEqual(mac[:8], custom_oui)


if __name__ == '__main__':
    unittest.main()
