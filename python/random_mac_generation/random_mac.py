#! /usr/bin/env python
"""
Generate random MAC address
Inspired by http://www.linux-kvm.com/sites/default/files/macgen.py
"""
from sys import argv
import random


DEFAULT_OUI = '00-16-3e'  # Xensource, Inc.


def randomMAC(oui=None):
    """returns a random MAC address, with optional +oui+ override"""
    mac_parts = [oui or DEFAULT_OUI]
    for limit in [0x7f, 0xff, 0xff]:
        mac_parts.append("%02x" % random.randint(0x00, limit))
    return '-'.join(mac_parts)


if __name__ == '__main__':
    print randomMAC(argv[1] if len(argv) > 1 else None)
