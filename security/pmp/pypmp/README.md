# #281

Using pypmp to call the PMP REST API from python.

## Notes

The
[PMP REST API](https://www.manageengine.com/products/passwordmanagerpro/help/restapi.html)
makes most features of [ManageEngine Password Manager Pro](https://www.manageengine.com/products/passwordmanagerpro/)
manageable and usable with token-authenticated HTTP calls.

There are a couple of existing python projects for interacting with the PMP API.
This is a quick test of the [pypmp](https://pypi.org/project/pypmp/) project

## Project Sources

The [pypmp pypi](https://pypi.org/project/pypmp/) page documents the latest release.
It has a broken link to the source however.

The [tristanlatr/pypmp](https://github.com/tristanlatr/pypmp) GitHub fork appears to be the code from which
the official release has been built from.
There is another relatively active fork [allenjeong/pypmp](https://github.com/allenjeong/pypmp) that is not fully merged.

## Installation

This tool uses the official pypmp library. Install with pip:

    pip install -r requirements.txt

### Example Script

The [pmp_api.py](./pmp_api.py) script is a simple example of various API calls using the pypmp library

    $ ./pmp_api.py -h
    usage: pmp_api.py [-h] [-r R] [-a A] resource_name

    Demonstrate basic PMP REST API calls with pypmp

    positional arguments:
    resource_name  (resources, accounts, account or password)

    options:
    -h, --help     show this help message and exit
    -r R           resource ID
    -a A           account ID

    Uses settings from environment: PMP_HOST (default: localhost) PMP_PORT (default: 7272) AUTHTOKEN

## Auth Failure

If an invalid token is provided:

    $ AUTHTOKEN=invalid ./pmp_api.py resources
    Request to https://ronda-u2:7272/restapi/json/v1/resources failed: API key received is not associated to any user. Authentication failed.
    Failed

## Get the Resources Owned and Shared to a User

[`../resources` endpoint](https://www.manageengine.com/products/passwordmanagerpro/help/restapi.html#getresource)

    $ ./pmp_api.py resources
    [{'RESOURCE DESCRIPTION': '', 'RESOURCE TYPE': 'Linux', 'RESOURCE ID': '1', 'RESOURCE NAME': 'res1', 'NOOFACCOUNTS': '1'}]

v## Get the Accounts that are Part of a Resource

[`../resources/<Resource ID>/accounts` endpoint](https://www.manageengine.com/products/passwordmanagerpro/help/restapi.html#getaccounts)

    $ ./pmp_api.py -r 1 accounts
    {'LOCATION': '', 'RESOURCE DESCRIPTION': '', 'RESOURCE TYPE': 'Linux', 'RESOURCE ID': '1', 'ACCOUNT LIST': [{'ACCOUNT_DESCRIPTION': '', 'ISFAVPASS': 'false', 'ACCOUNT ID': '1', 'AUTOLOGONLIST': ['SSH', 'Telnet'], 'ACCOUNT NAME': 'admin', 'PASSWORDREQUEST_REASON_MANDATORY': 'true', 'PASSWORD STATUS': '****', 'ISREMOTEAPPONLY': 'false', 'ACCOUNT PASSWORD POLICY': 'Strong', 'IS_USER_WITH_COMMAND_CONTROL_ROLE': 'false', 'AUTOLOGONSTATUS': 'ALLOWED', 'IS_TICKETID_REQD_ACW': 'false', 'IS_COMMAND_CONTROL_CONFIGURED': 'false', 'PASSWDID': '1', 'IS_TICKETID_REQD_MANDATORY': 'false', 'IS_TICKETID_REQD': 'false', 'ISREASONREQUIRED': 'false'}], 'DEPARTMENT': '', 'PASSWORDREQUEST_REASON_MANDATORY': 'true', 'RESOURCE OWNER': 'admin', 'RESOURCE PASSWORD POLICY': 'Strong', 'IS_LOCAL_ACCOUNTS_AUTOLOGON_RESTRICTED': 'false', 'RESOURCE URL': '', 'IS_SSH_RESTRICTED': 'false', 'NEWSSHTERMINAL': 'false', 'DOMAIN NAME': '', 'ALLOWOPENURLINBROWSER': 'true', 'RESOURCE NAME': 'res1', 'DNS NAME': '1.2.3.4', 'ISRDPRESTRICTED': 'true'}

## Get Details of an Account

[`../resources/<Resource ID>/accounts/<Account ID>` endpoint](https://www.manageengine.com/products/passwordmanagerpro/help/restapi.html#getaccountdetails)

    $ ./pmp_api.py -r 1 -a 1 account
    {'DESCRIPTION': 'N/A', 'PASSWDID': '1', 'LAST MODIFIED TIME': 'N/A', 'EXPIRY STATUS': 'Valid', 'COMPLIANT REASON': 'Minimum length must be 8', 'PASSWORDREQUEST_REASON_MANDATORY': 'true', 'PASSWORD STATUS': '****', 'PASSWORD POLICY': 'Strong', 'COMPLIANT STATUS': 'Non-Compliant', 'LAST ACCESSED TIME': 'Mar 13, 2024 08:50 PM'}

## Get the Password of an Account that is Part of a Resource

[`../resources/<Resource ID>/accounts/<Account ID>/password` endpoint](https://www.manageengine.com/products/passwordmanagerpro/help/restapi.html#getpwd)

    $ ./pmp_api.py -r 1 -a 1 password
    admin

## Credits and References

* [PMP REST API Docs](https://www.manageengine.com/products/passwordmanagerpro/help/restapi.html)
* [pypmp](https://pypi.org/project/pypmp/) - pypi
* [tristanlatr/pypmp](https://github.com/tristanlatr/pypmp) - GitHub, current release code
* [allenjeong/pypmp](https://github.com/allenjeong/pypmp) - GitHub, alternative/diverged fork
* [PasswordManPro_CLI](https://github.com/rmetcalf9/PasswordManPro_CLI) - GitHub
* [argparse](https://docs.python.org/3/library/argparse.html)
