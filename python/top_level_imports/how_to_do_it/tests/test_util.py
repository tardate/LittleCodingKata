import unittest
import constants
import util.helper as helper


class UtilTests(unittest.TestCase):

    def test_message(self):
        self.assertEqual(helper.message(), constants.HELLO)
