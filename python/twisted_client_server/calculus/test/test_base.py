from calculus.base import Calculation
from twisted.trial import unittest


class CalculationTestCase(unittest.TestCase):
    """Assures the Calculation business-logic class works as expected."""

    def setUp(self):
        self.calc = Calculation()

    def try_valid_operation(self, operation, a, b, expected):
        result = operation(a, b)
        self.assertEqual(result, expected)

    def try_invalid_operation(self, operation):
        self.assertRaises(TypeError, operation, "foo", 2)
        self.assertRaises(TypeError, operation, "bar", "egg")
        self.assertRaises(TypeError, operation, [3], [8, 2])
        self.assertRaises(TypeError, operation, {"e": 3}, {"r": "t"})

    def test_add(self):
        self.try_valid_operation(self.calc.add, 3, 8, 11)

    def test_bad_add(self):
        self.try_invalid_operation(self.calc.add)

    def test_subtract(self):
        self.try_valid_operation(self.calc.subtract, 7, 3, 4)

    def test_bad_subtract(self):
        self.try_invalid_operation(self.calc.subtract)

    def test_multiply(self):
        self.try_valid_operation(self.calc.multiply, 12, 5, 60)

    def test_bad_multiply(self):
        self.try_invalid_operation(self.calc.multiply)

    def test_divide(self):
        self.try_valid_operation(self.calc.divide, 12, 5, 2)

    def test_bad_divide(self):
        self.try_invalid_operation(self.calc.divide)
