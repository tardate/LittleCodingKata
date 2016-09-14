#! /usr/bin/env python
import begin

@begin.start(auto_convert=True)
def add(a=0.0, b=0.0):
    """ Add two numbers """
    print(a + b)
