# inkscape

Installing inkscape from source on MacOS.

## Notes

It seems the homebrew keg for inkscape.

[0.92.4](https://inkscape.org/release/inkscape-0.92.4/)

```bash
wget https://inkscape.org/gallery/item/13330/inkscape-0.92.4_A6N0YOn.tar.bz2
tar -zxvf inkscape-0.92.4_A6N0YOn.tar.bz2
cd inkscape-0.92.4/
```

...

I have inkscape installed with brew, but now I forget how I got it!

$ brew list inkscape
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/bin/inkscape
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/bin/inkview
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/lib/inkscape/ (13 files)
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/share/applications/inkscape.desktop
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/share/icons/ (7 files)
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/share/inkscape/ (905 files)
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/share/locale/ (90 files)
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/share/man/ (8 files)
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1/share/metainfo/inkscape.appdata.xml

$ brew info inkscape
wwwvalpe/caskformula/inkscape: stable 0.92.2, HEAD
Professional vector graphics editor
<https://inkscape.org/>
/usr/local/Cellar/inkscape/HEAD-5bc3bdf_1 (1,034 files, 122.3MB) *
  Built from source on 2019-06-15 at 05:16:55 with: --branch-0.92
From: <https://github.com/wwwvalpe/homebrew-caskformula/blob/master/Formula/inkscape.rb>
==> Dependencies
Build: automake ✔, cmake ✘, libtool ✔, boost-build ✘, intltool ✔, pkg-config ✔
Required: bdw-gc ✔, boost ✔, cairomm ✔, gettext ✔, glibmm ✘, gsl ✔, hicolor-icon-theme ✔, libsoup ✘, little-cms ✔, pango ✘, popt ✔, poppler ✘, potrace ✔, gtkmm ✘
==> Options
--branch-0.92
  When used with --HEAD, build from the 0.92.x branch
--with-gtk3
  Build Inkscape with GTK+3 (Experimental)
--HEAD
  Install HEAD version

## Credits and References

* [inkscape](https://inkscape.org/)
