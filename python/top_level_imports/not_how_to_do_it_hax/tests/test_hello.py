import unittest
import not_how_to_do_it_hax.constants as constants
import not_how_to_do_it_hax.hello as hello


class HelloTests(unittest.TestCase):

    def test_get_greeting(self):
        self.assertEqual(hello.get_greeting(), constants.HELLO)
