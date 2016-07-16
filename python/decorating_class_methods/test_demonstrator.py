#! /usr/bin/env python
import unittest
import logging
from mock import patch, call
import demonstrator


class TestBase(unittest.TestCase):

    def setUp(self):
        logging.disable(logging.CRITICAL)
        self.instance = demonstrator.Demonstrator()

    def tearDown(self):
        logging.disable(logging.NOTSET)


class TestApple(TestBase):

    def call_method(self):
        return self.instance.apples([], 'test apples', 33)

    def test_method_works_as_expected(self):
        result = self.call_method()
        self.assertEqual(['test apples', 33], result)

    @patch('demonstrator.log.info')
    def test_decorator_logging(self, mock_log_info):
        self.call_method()
        mock_log_info.assert_has_calls([
            call("method_wrapper.before: Demonstrator.apples called with args: ([], 'test apples', 33) kwargs: {}"),
            call("running apples with payload: [], message: 'test apples', example_id: 33"),
            call("method_wrapper.after: returns ['test apples', 33]")
        ])


class TestOrange(TestBase):

    def call_method(self):
        return self.instance.oranges([], 'test oranges', 333)

    def test_method_works_as_expected(self):
        result = self.call_method()
        self.assertEqual(['test oranges', 333], result)

    @patch('demonstrator.log.info')
    def test_decorator_logging(self, mock_log_info):
        self.call_method()
        mock_log_info.assert_has_calls([
            call("wrapped_method_wrapper.before: Demonstrator.oranges called with args: ([], 'test oranges', 333) kwargs: {}"),
            call("running oranges with payload: [], message: 'test oranges', example_id: 333"),
            call("wrapped_method_wrapper.after: returns ['test oranges', 333]")
        ])


class TestDocstrings(TestBase):

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
