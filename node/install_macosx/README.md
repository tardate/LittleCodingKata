# Installing Node.js MacOS

Installing and maintaining Node.js on MacOS

## Notes

I user homebrew to install and maintain node on MacOS:

```
$ brew install node
$ node --version
v11.15.0

```
## Node Version Manager

I used to use [nvm](https://github.com/nvm-sh/nvm)
but since switched to [n](https://github.com/tj/n)

```
$ npm install -g n
$ n --version
4.1.0
```

To install or update nvm, you can use the install script using cURL:

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
```

## Updating Node

To install the latest available..

```
$ sudo n latest
$ n ls
    ...
    11.14.0
    11.15.0
    12.0.0
    12.1.0
    12.2.0
    12.3.0
    12.3.1
    12.4.0
    12.5.0
    12.6.0
    12.7.0
  ο 12.8.0
$ node --version
v12.8.0
```

## Updating NPM

```
$ npm install -g npm
$ npm --version
6.10.2
```

## Credits and References

* [nodejs.org](https://nodejs.org/en/)
* [n](https://github.com/tj/n) - Node version management
* [nvm](https://github.com/nvm-sh/nvm)
