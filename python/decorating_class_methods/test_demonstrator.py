#! /usr/bin/env python
import unittest
import logging
import demonstrator


class TestBasicMethods(unittest.TestCase):

    def setUp(self):
        logging.disable(logging.CRITICAL)
        self.instance = demonstrator.Demonstrator()

    def tearDown(self):
        logging.disable(logging.NOTSET)

    def test_apples_works_as_expected(self):
        payload = []
        message = 'test apples'
        result = self.instance.apples(payload, message, 33)
        self.assertEqual(['test apples', 33], result)

    def test_oranges_works_as_expected(self):
        payload = []
        message = 'test oranges'
        result = self.instance.oranges(payload, message, 333)
        self.assertEqual(['test oranges', 333], result)


class TestDocstrings(unittest.TestCase):

    def setUp(self):
        self.instance = demonstrator.Demonstrator()

    def test_oranges_doc_is_available(self):
        self.assertEqual(
            ' Doc for oranges(). ',
            self.instance.oranges.__doc__
        )

    @unittest.expectedFailure
    def test_apples_doc_is_available(self):
        self.assertEqual(
            ' Doc for apples(). ',
            self.instance.apples.__doc__
        )

    def test_apples_doc_is_actually_hidden(self):
        self.assertIsNone(self.instance.apples.__doc__)


class TestFunctionNames(unittest.TestCase):

    def setUp(self):
        self.instance = demonstrator.Demonstrator()

    def test_oranges_is_correctly_named(self):
        self.assertEqual(
            'oranges',
            self.instance.oranges.__name__
        )

    @unittest.expectedFailure
    def test_apples_is_correctly_named(self):
        self.assertEqual(
            'apples',
            self.instance.apples.__name__
        )

    def test_apples_actually_has_the_decorators_name(self):
        self.assertEqual(
            'wrapper',
            self.instance.apples.__name__
        )


if __name__ == '__main__':
    unittest.main()
