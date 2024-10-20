# #077

Testing Punch for static site generation (obsolete).

## Notes

> Punch is a simple, intuitive web publishing framework that will delight both designers and developers.

I tried this some time back and it worked quite well (with nvm v0.11.3 and node version ???).

The project has however not kept up with node changes, and the [GitHub repo](https://github.com/laktek/punch) has been archived.

If you try and run punch these days, all kinds of errors result (`TypeError: Mime.extension is not a function`)
since dependencies are not well constrained.

## Creating a Test Site

Requires a working node.js installation.

Install punch..

```
$ npm install -g punch
...
/usr/local/Cellar/node/12.4.0/bin/punch -> /usr/local/Cellar/node/12.4.0/lib/node_modules/punch/bin/punch
```

### Generate a site

```
$ punch setup testsite
$ cd testsite/
$ punch s
Running Punch server on localhost:9009

```

![testsite_home](./assets/testsite_home.png?raw=true)


### generate full site for distribution

```
$ punch g --blank
```

### Generated Site

The punch server does not work any longer..
```
$ punch s
Running Punch server on localhost:9009
TypeError: Mime.extension is not a function
    at Object.getExtension (/usr/local/Cellar/node/12.4.0/lib/node_modules/punch/lib/utils/path_utils.js:18:43)

```

Nor does the generator...

```
$ punch g --blank
internal/process/main_thread_only.js:42
    cachedCwd = binding.cwd();
```

## Credits and References

* [punch](http://laktek.github.io/punch/)
* [punch](https://github.com/laktek/punch) - GitHub
