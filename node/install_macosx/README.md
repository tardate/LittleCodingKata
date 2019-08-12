# Installing Node.js MacOSX

Installing and maintaining Node.js on MacOSX

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

I user homebrew to install and maintain node on MacOSX:

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

## Credits and References

* [nodejs.org](https://nodejs.org/en/)
* [n](https://github.com/tj/n) - Node version management
* [nvm](https://github.com/nvm-sh/nvm)
