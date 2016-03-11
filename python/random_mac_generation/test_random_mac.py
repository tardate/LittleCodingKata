#! /usr/bin/env python
import unittest
from random_mac import randomMAC


class RandomMacTests(unittest.TestCase):

    def testValidMacStructure(self):
        mac = randomMAC()
        self.assertRegexpMatches(mac, r'[\da-f]{2}-[\da-f]{2}-[\da-f]{2}-[\da-f]{2}')

    def testNoTwoTheSame(self):
        mac1 = randomMAC()
        mac2 = randomMAC()
        self.assertNotEqual(mac1, mac2)

    def testDefaultOUI(self):
        mac = randomMAC()
        self.assertEqual(mac[:8], '00-16-3e')

    def testOverrideOUI(self):
        custom_oui = '11-22-33'
        mac = randomMAC(custom_oui)
        self.assertEqual(mac[:8], custom_oui)


if __name__ == '__main__':
    unittest.main()
