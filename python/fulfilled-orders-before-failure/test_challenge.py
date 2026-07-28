#! /usr/bin/env python
import unittest
from challenge import fulfilledOrdersBeforeFailure


class FulfilledOrdersBeforeFailureTests(unittest.TestCase):
    def test_example1(self):
        self.assertEqual(
            2,
            fulfilledOrdersBeforeFailure(
                [["chocolate"],["chocolate"],["chocolate"]],
                { "chocolate": 2 }
            )
        )

    def test_example2(self):
        self.assertEqual(
            3,
            fulfilledOrdersBeforeFailure(
                [["vanilla","vanilla"],["chocolate","mint"],["strawberry"],["strawberry","mint"]],
                { "vanilla": 2, "chocolate": 1, "mint": 1, "strawberry": 5 }
            )
        )

    def test_example3(self):
        self.assertEqual(
            0,
            fulfilledOrdersBeforeFailure(
                [["rocky road"],["vanilla"]],
                { "vanilla": 3 }
            )
        )


if __name__ == '__main__':
    unittest.main()
