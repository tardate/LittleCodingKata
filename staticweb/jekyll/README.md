# Jekyll

Test-driving some techniques for building static sites with Jekyll.


[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

Jekyll is a simple, blog-aware, static site generator. It takes a template directory containing raw text files in various formats, runs it through a converter (like Markdown) and our Liquid renderer, and spits out a complete, ready-to-publish static website suitable for serving with your favorite web server.


### Quickstart - Create and run a Template Site

See the [quickstart guide](http://jekyllrb.com/docs/quickstart/).

```
gem install bundler jekyll
jekyll new myblog
cd myblog
bundle
jekyll serve
open http://localhost:4000
```

![myblog](./assets/myblog.png?raw=true)

#### Build & watch for changes

```
$ jekyll build --watch
# => The current folder will be generated into ./_site,
#    watched for changes, and regenerated automatically.
```


### GitHub Automatic Page Generator (deprecated)

The Automatic Page Generator is an old (deprecated) GitHub feature for generating a web site from a repository.
This has now been replaced by Jekyll-based template. GitHub provide some migration support from the settings page.

The [gh-pages-auto](https://github.com/tardate/gh-pages-auto) repo started with the Automatic Page Generator.

* [gh-pages-auto GitHub Repo](https://github.com/tardate/gh-pages-auto) - repo originally built with the Automatic Page Generator
* [gh-pages-auto web](http://tardate.github.io/gh-pages-auto/) - how it appears when served by GitHub Pages


### GitHub Pages - Simplified Publishing

Provided you work within the currently supported
[versions](https://pages.github.com/versions/) of Jekyll and related utilities,
then publishing a web site from a GitHub repository can be a very simple process.

The blog post [Publishing with GitHub Pages, now as easy as 1, 2, 3](https://github.com/blog/2289-publishing-with-github-pages-now-as-easy-as-1-2-3)
describes the essentials.

* [gh-pages-simple GitHub Repo](https://github.com/tardate/gh-pages-simple) - basic repo using implicit Jekyll page generation
* [gh-pages-simple web](http://gh-pages-simple.tardate.com) - how it appears when served by GitHub Pages

![landing-gh-pages-simple](./assets/landing-gh-pages-simple.png?raw=true)


### GitHub Pages - Offline Publishing

One of the problems with using automatic GitHub Pages publishing is that you must accept the currently supported
[versions](https://pages.github.com/versions/) of Jekyll and related utilities.

If this is a deal-breaker, then an alternative is to build Jekyll pages offline using a custom mix of utilities.
Then use GitHub Pages to serve the resulting site.

In [gh-pages-offline](https://github.com/tardate/gh-pages-offline) I use a customised jekyll-readme-index gem that is not supported by GitHub Pages servers

* [gh-pages-offline GitHub Repo](https://github.com/tardate/gh-pages-offline) - repo that uses offline generation
* [gh-pages-offline web](http://gh-pages-offline.tardate.com) - how it appears when served by GitHub Pages


### Themes and Templates

* [Themes listing](https://github.com/jekyll/jekyll/wiki/Themes) - from the jekyll wiki
* [jekyllthemes.org](http://jekyllthemes.org/) - visual browser of submitted themes
* [Adding a Jekyll theme to your GitHub Pages site](https://help.github.com/articles/adding-a-jekyll-theme-to-your-github-pages-site/)

#### Left

Zach Holman published a starter-repo called [left](https://github.com/holman/left) that provides all the scaffolding for a minimalist site.
It is described in his [blog post on left](https://zachholman.com/posts/left/).

Basing a site on left is simply a matter of cloning the repo and customising as required:

* [gh-pages-left GitHub Repo](https://github.com/tardate/gh-pages-left) - repo for a site based on left
* [gh-pages-left web](http://gh-pages-left.tardate.com) - how it appears when served by GitHub Pages

#### Pixyll

A simple, beautiful Jekyll theme that's mobile first [pixyll.com](http://pixyll.com),
[pixyll on GitHub](https://github.com/johnotander/pixyll).


### Jekyll Tips

* [Jekyll Cheat Sheet](http://jekyll.tips/jekyll-cheat-sheet/)
* [Organizing Jekyll Pages](http://damonbauer.me/organizing-jekyll-pages/) - Damon Bauer

#### Relative Paths

All generated internal links are relative to the site root. This creates an issue on GitHub Pages since the default site root will be
`<org/username>.tardate.io/repository-name/`.

The best way around this is to serve GitHub Pages on a custom URL, so the site works fine without any special modification
when served on GitHub Pages and also when served locally with:

```
bundle exec jekyll build
```

Handling paths was improved with the `relative_url` filter - see [Jekyll 3.3 release notes](https://jekyllrb.com/news/2016/10/06/jekyll-3-3-is-here/#relativeurl-and-absoluteurl-filters).


## Credits and References
* [jekyll](https://jekyllrb.com/) - main site
* [jekyll - GitHub](https://github.com/jekyll/jekyll)
* [Publishing with GitHub Pages, now as easy as 1, 2, 3](https://github.com/blog/2289-publishing-with-github-pages-now-as-easy-as-1-2-3)
* [Zach Holman's left](https://github.com/holman/left)

