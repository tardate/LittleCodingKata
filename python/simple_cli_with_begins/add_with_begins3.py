#! /usr/bin/env python3
import begin

@begin.start(auto_convert=True)
def add(a: 'First value' = 0.0, b: 'Second value' = 0.0):
    """ Add two numbers """
    print(a + b)
