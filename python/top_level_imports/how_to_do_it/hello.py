import sys
import util.helper as helper


def get_greeting():
    print "Current top of sys.path: {}".format(sys.path[0])
    return helper.message()

def main():
    print get_greeting()

if __name__ == '__main__':
    main()
