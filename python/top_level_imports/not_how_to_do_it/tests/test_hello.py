import unittest
import constants
import hello


class HelloTests(unittest.TestCase):

    def test_get_greeting(self):
        self.assertEqual(hello.get_greeting(), constants.HELLO)
