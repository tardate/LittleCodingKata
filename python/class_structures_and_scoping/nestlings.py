#! /usr/bin/env python

class Demo(object):

    FLAVOUR = ('apple', 'peach')

    def get_flavour(self, index):

        def inner(index):
            return self.FLAVOUR[index]

        return inner(index)

if __name__ == '__main__':
    print(Demo().get_flavour(0))
    print(Demo().get_flavour(1))
