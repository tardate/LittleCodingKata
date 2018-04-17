# The Catalog

This is a simple Javascript catalog for building the
[LittleCodingKata GitHub Pages site](https://codingkata.tardate.com).

It is a simple bootstrap/datatables page with the main entry point in [index.html](../index.html).
Catalog data is loaded from [catalog.json](./catalog.json), which is consolidated from `.catalog_metadata` I've added to each project.

The [make.py](./make.py) utility script is used to maintain the catalog:

```
$ catalog/make.py generate  # builds the catalog from catalog metadata
```


## Hosting

I'm using [Netlify](https://www.netlify.com/) to run the catalog site directly from the GitHub repository.

Note: I previously used GitHub Pages, but switched to Netlify as that allows me to use free SSL certificates from [LetsEncrypt](https://letsencrypt.org/).


## Credits and References
* [Netlify](https://www.netlify.com/)
* [LetsEncrypt](https://letsencrypt.org/)
* [GitHub Pages](https://pages.github.com/)
* [bootstrap](http://getbootstrap.com)
* [datatables](http://datatables.net/)
