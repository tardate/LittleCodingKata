# Installing Node.js Ubuntu

Installing and maintaining Node.js on Ubuntu

## Notes

I'm currently running Ubuntu 22.04:

    $ uname -v
    #44~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Jun 18 14:36:16 UTC 2

The version of Node.js included with Ubuntu 22.04, version 12.22.9, is an LTS release. It is technically outdated, but should be supported until the release of Ubuntu 24.04.

    $ sudo apt install nodejs
    $ node -v
    v12.22.9

So while that is possible, I'll remove it to install a later version:

    sudo apt remove nodejs

To install node v22, I'm using nvm:

    $ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    ..
    $ nvm install 22
    ..
    $ node -v
    v22.6.0

Note: this requires a working curl. The version installed with snap is not compatible. So if necessary, replace it with on installed via apt:

    sudo snap remove curl
    sudo apt-get update
    sudo apt-get install curl

## Credits and References

* [How To Install Node.js on Ubuntu 22.04](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-22-04)
