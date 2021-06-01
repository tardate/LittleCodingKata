# aws-cli

Installing the running the AWS CLI

## Notes

Just the basics of instlaling and running the AWS CLI, updated for version 2.

## AWS CLI version 2

[Installing, updating, and uninstalling the AWS CLI version 2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

### Local Install - MacOSX

Download and run the installer: https://awscli.amazonaws.com/AWSCLIV2.pkg
After installation:

    $ which aws
    /usr/local/bin/aws
    $ aws --version
    aws-cli/2.2.7 Python/3.8.8 Darwin/17.7.0 exe/x86_64 prompt/off

### Running With Docker

The CLI is now also available as a docker image:

    $ docker run --rm -it amazon/aws-cli --version
    aws-cli/2.2.7 Python/3.8.8 Linux/4.19.76-linuxkit docker/x86_64.amzn.2 prompt/off

To share aws credentials in the local `~/.aws` folder, map the volume:

    $ docker run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli --profile myprofile s3 ls s3://example.bucket
    ... returns authorised results..


## AWS CLI version 1

[Installing, updating, and uninstalling the AWS CLI version 1](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv1.html)

### Installing AWS CLI version 1

A long time ago (back in python 2 days!), I installed, the [AWS CLI tools](https://docs.aws.amazon.com/cli/latest/reference/) with pip:

    $ pip install awscli
    $ aws --version
    aws-cli/1.16.63 Python/2.7.15 Darwin/17.7.0 botocore/1.12.53

### Uninstalling AWS CLI version 1

This is the problem with locally installed packages - they can become unhinged.
My old aws cli is installed and works, but pip can't uninstall it...

```
$ which aws
/usr/local/bin/aws

$ pip uninstall awscli
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7. More details about Python 2 support in pip, can be found at https://pip.pypa.io/en/latest/development/release-process/#python-2-support
WARNING: Skipping awscli as it is not installed.
```

That's because I've re-installed python so many times since, and also switched to using pyenv, that the actual awscli site-package
is no longer on the paths that my default python2/pip2 executable will find:

```
$ find / -name awscli -type d
...
/usr/local/lib/python2.7/site-packages/awscli
...
```

That's because two separate python 2 installations. pip is coming from the pyenv version
```
$ pip --version
pip 19.2.3 from /Users/paulgallagher/.pyenv/versions/2.7.18/lib/python2.7/site-packages/pip (python 2.7)
```

while aws is linked to an older python 2 - I think this is the defualt MacOSX python:
```
$ head -1 /usr/local/bin/aws
#!/usr/local/opt/python@2/bin/python2.7
```

So for now I just took the cheats way out and moved the aws command out of the way so I can install v2:

    mv /usr/local/bin/aws /usr/local/bin/aws.v1

## Credits and References

* [AWS Command Line Interface Documentation](https://docs.aws.amazon.com/cli/index.html)
