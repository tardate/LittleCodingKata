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
