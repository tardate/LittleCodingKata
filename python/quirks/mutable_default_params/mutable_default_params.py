#! /usr/bin/env python
#
# See:
# http://stackoverflow.com/questions/1132941/least-astonishment-in-python-the-mutable-default-argument
# http://docs.python-guide.org/en/latest/writing/gotchas/
#
import unittest


class RefParamTests(unittest.TestCase):

    def quirky_accummulator(self, value, list=[]):
        list.append(value)
        return list

    def ok_accummulator(self, value, list=None):
        if list is None:
            list=[]
        list.append(value)
        return list

    def test_quirky(self):
        self.quirky_accummulator(1)
        self.quirky_accummulator(2)
        result = self.quirky_accummulator(3)
        self.assertEqual(result, [1,2,3])

    def test_fixed(self):
        self.ok_accummulator(1)
        self.ok_accummulator(2)
        result = self.ok_accummulator(3)
        self.assertEqual(result, [3])


if __name__ == '__main__':
    unittest.main()
