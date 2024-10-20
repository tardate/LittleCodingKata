# #014 Highcharts with Bower

Demonstrate the process of installing and packaging Highcharts with bower.

[![demo](./assets/demo.png?raw=true)](https://codingkata.tardate.com/javascript/highcharts_with_bower/example.html)

## Notes

Bower is a package manager for web components that may contain HTML, CSS, JavaScript, fonts or even image files.

HighCharts is one of the leading Javascript charting packages.

Now dance!

## Installation

### Install Bower

Requires `npm`, then install bower globally:

    npm install -g bower

### Highcharts Installation

    bower install highcharts

Or to install and add highcharts to `bower.json`

    bower install highcharts --save

### Installing from bower.json

With `bower.json` prepared, install all the dependencies (including highcharts)

    bower install


## Compiling for Distribution

The highcharts sources installed in `bower_components` are not actually checked-in the repo
or included in the distribution. While you could do that, the approach I'll use
here is to `compile` javascript dependencies for distribution.

For that I'll use `grunt` with the `grunt-bower-concat` to generate `app/compiled.js`.

Install npm dependencies:

```
npm install -g grunt
npm install -g grunt-cli
npm install # from package.json
```

Then compile the bower components:

```
$ cat Gruntfile.coffee
module.exports = (grunt)->

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    bower_concat: {
      all: {
        dest: 'app/compiled.js',
        bowerOptions: {
          relative: false
        }
      }
    }
  })

  grunt.loadNpmTasks('grunt-bower-concat')

  grunt.registerTask('default', ['bower_concat'])

$ grunt
Running "bower_concat:all" (bower_concat) task
File app/compiled.js created.

Done.
```

## Example

The example in [example.html](./example.html) is an adaptation of the
[HighCharts 'First Chart' example](http://www.highcharts.com/docs/getting-started/your-first-chart).

Or run the demo [live from GitHub Pages](https://codingkata.tardate.com/javascript/highcharts_with_bower/example.html).


## Credits and References

* [bower.io](http://bower.io/)
* [Highcharts](http://www.highcharts.com/)
* [Install from Bower](http://www.highcharts.com/docs/getting-started/install-from-bower) - highcharts
* [grunt-bower-concat](https://github.com/sapegin/grunt-bower-concat)
