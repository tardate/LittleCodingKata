# #xxx Preventing Path Traversal

Examining the path traversal vulnerability in Node.js and demonstrating mitigations.

## Notes

Path traversal vulnerabilities generally stem from using unsanitized file or folder names to construct full paths for reading or writing files.
This allows relative paths to be constructed with '..' and thus "escape" from safe/authorized file locations and potentially access sensitive information
or deposit malicious content.

The [Node.js `path.join()` method](https://nodejs.org/api/path.html#pathjoinpaths)
does not prevent this (by design),
nor will simply running the code in a sandboxed environment (e.g. [Chromium Sandbox](https://chromium.googlesource.com/chromium/src/+/HEAD/docs/design/sandbox.md))
without also configuring user privileges and file permissions appropriately.

For example, if the intention is to ensure all user files are kept within `basePath`,
allowing unsanitized paths can result in some hairy situations like:

```js
path.join(basePath, '../../../etc/passwd'); // !!
```

A simple mitigation is to use
[`path.resolve()`](https://nodejs.org/api/path.html#pathresolvepaths)
and check the resulting path is within the intended location, for example:

```js
const safePath = path.resolve(safeBasePath, userPath);
if (safePath.startsWith(safeBasePath)) {
  // all ok, proceed..
} else {
  // BAD - raise an error or handle appropriately
}
```

### Running the Demonstration

See [example.js](./example.js) for some examples of using path methods,
including safe and unsafe path traversal scenarios.
Running the examples:

```sh
$ node example.js

Demonstrating some path methods...
Get the directory name of the current module with __dirname: /Users/paulgallagher/MyGithub/tardate/LittleCodingKata/node/preventing-path-traversal
Get the file name of the current module with __filename: /Users/paulgallagher/MyGithub/tardate/LittleCodingKata/node/preventing-path-traversal/example.js
Building paths relative to the current module with join(): /Users/paulgallagher/MyGithub/tardate/LittleCodingKata/node/preventing-path-traversal/config/app-config.json

Demonstrating path traversal...
relativeToRoot(etc/passwd) returns: ../../../../../../../etc/passwd
unsafePathTraversal given etc/passwd, returns: /Users/paulgallagher/MyGithub/tardate/LittleCodingKata/node/preventing-path-traversal/etc/passwd
unsafePathTraversal given ../../../../../../../etc/passwd, returns: /etc/passwd
safePathTraversal given etc/passwd, returns: /Users/paulgallagher/MyGithub/tardate/LittleCodingKata/node/preventing-path-traversal/etc/passwd
safePathTraversal directory traversal attempt detected and prevented! (given ../../../../../../../etc/passwd, would return: /etc/passwd)
```

## Example Source

See [example.js](./example.js):

```js
const path = require('path');

function demoPathMethods() {
  console.log('\nDemonstrating some path methods...');
  console.log('Get the directory name of the current module with __dirname:', __dirname);
  console.log('Get the file name of the current module with __filename:', __filename);
  const configPath = path.join(__dirname, 'config', 'app-config.json');
  console.log('Building paths relative to the current module with join():', configPath);
}

function relativeToRoot(userPath) {
  const relativePath = path.relative(__dirname, path.sep);
  return path.join(relativePath, userPath);
}

function unsafePathTraversal(userPath) {
  const unsafePath = path.join(__dirname, userPath);
  console.log('unsafePathTraversal given %s, returns: %s', userPath, unsafePath);
}

function safePathTraversal(userPath) {
  const safeBasePath = __dirname;
  const safePath = path.resolve(safeBasePath, userPath);

  // Ensure the resolved path is within the safe base directory
  if (safePath.startsWith(safeBasePath)) {
    console.log('safePathTraversal given %s, returns: %s', userPath, safePath);
  } else {
    console.error('safePathTraversal directory traversal attempt detected and prevented! (given %s, would return: %s)', userPath, safePath);
  }
}

demoPathMethods();
console.log('\nDemonstrating path traversal...');
console.log('relativeToRoot(%s) returns: %s', 'etc/passwd', relativeToRoot('etc/passwd'));
unsafePathTraversal('etc/passwd');
unsafePathTraversal(relativeToRoot('etc/passwd'));
safePathTraversal('etc/passwd');
safePathTraversal(relativeToRoot('etc/passwd'));
```

## Credits and References

* [Node.js v26.0.0 documentation: path](https://nodejs.org/api/path.html)
* [Node.js path.join() method](https://nodejs.org/api/path.html#pathjoinpaths)
* [Node.js path.resolve() method](https://nodejs.org/api/path.html#pathresolvepaths)
* [Node.js path module - w3schools](https://www.w3schools.com/nodejs/nodejs_path.asp)
* [Chromium Sandbox](https://chromium.googlesource.com/chromium/src/+/HEAD/docs/design/sandbox.md)
