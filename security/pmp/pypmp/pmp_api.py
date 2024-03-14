#! /usr/bin/env python
import os
import urllib3
import argparse
from pypmp import PasswordManagerProClient


class PmpCommandRunner(object):

    def __init__(self, args):
        self.args = args

    @property
    def resource_method(self):
        return f'get_{self.args.resource_name}'

    @property
    def resource_id(self):
        return self.args.r

    @property
    def account_id(self):
        return self.args.a

    @property
    def pmp(self):
        if not hasattr(self, '_pmp'):
            urllib3.disable_warnings()
            self._pmp = PasswordManagerProClient(
              os.environ.get('PMP_HOST', 'localhost'),
              os.environ.get('AUTHTOKEN', 'not-set'),
              port=os.environ.get('PMP_PORT', 7272),
              verify=False
            )
        return self._pmp

    def get_resources(self):
        print(self.pmp.get_resources())

    def get_accounts(self):
        print(self.pmp.get_accounts(resource_id=self.resource_id))

    def get_account(self):
        print(self.pmp.get_account(resource_id=self.resource_id, account_id=self.account_id))

    def get_password(self):
        print(self.pmp.get_account_password(resource_id=self.resource_id, account_id=self.account_id))

    def run(self):
        if hasattr(self, self.resource_method):
            getattr(self, self.resource_method, None)()
        else:
            print('invalid resource_name')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Demonstrate basic PMP REST API calls with pypmp',
        epilog=(
            'Uses settings from environment:' \
            '  PMP_HOST (default: localhost)' \
            '  PMP_PORT (default: 7272)' \
            '  AUTHTOKEN' \
        )
    )
    parser.add_argument('resource_name', help='(resources, accounts, account or password)')
    parser.add_argument('-r', help='resource ID', type=int)
    parser.add_argument('-a', help='account ID', type=int)
    PmpCommandRunner(parser.parse_args()).run()
