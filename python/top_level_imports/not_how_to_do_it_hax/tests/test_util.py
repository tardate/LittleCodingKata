import unittest
import not_how_to_do_it_hax.constants as constants
import not_how_to_do_it_hax.util.helper as helper


class UtilTests(unittest.TestCase):

    def test_message(self):
        self.assertEqual(helper.message(), constants.HELLO)
