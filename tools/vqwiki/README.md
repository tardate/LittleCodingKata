# #xxx VQWiki

About the Very Quick Wiki Java-based WikiWikiWeb clone. The project is now officially abandoned, and I address exporting data from VQWiki.

## Notes

[Very Quick Wiki](https://sourceforge.net/projects/veryquickwiki/) is a Java Server Pages based WikiWikiWeb clone. The project is now officially abandoned,
with the last release 2.8.1 in 2009-03-01.

I am making these notes in 2026 - long after I last used VQWiki - so I'm not going to try and get it running again.

I used VQWiki for a few years as my personal notes system, having previously used Lotus Notes for this purpose. Around 2009 I moved to a combination of Google Docs and GitHub for my notes.

I do recall loving the WikiWikiWeb-style of personal notes recording, but the infrastructure required to run VQWiki was a significant impediment.

I did use <https://tiddlywiki.com/> for a while, and liked the simplicity: TiddlyWiki stores its data and code in a single HTML file, requiring no installs, no external dependencies, just a web browser. Ultimately though, I've gravitated to GitHub for all my notes as it is both simple, yet can handle much more than just text.

### Data Storage

By default, VQWiki stores data in text files. The file-system is set up in the user's home directory. Every topic gets written to one text file named as the topic with a "txt" extension.

VQWiki can be easily configured to use database persistence, which leads to much better performance for larger wikis. The  default database choice is MySQL

### Export

VQWiki provided an Export2HTML feature as a Special Page:

> You can save the entire wiki to a set of HTML files and download them for local archiving. The contents of the wiki will appear as a single large ZIP archive, which you can then save to your local hard drive.

If you are no longer running VQWiki, this is not much help of course

### A Simple Export Script

I wrote a little export script in Perl to dump my VQWiki database.
IIRC I not longer had a working VQWiki installation, but did have access to the MySQL database.

See [vqx.pl](./vqx.pl).

## Credits and References

* <https://sourceforge.net/projects/veryquickwiki/>
* [vqwiki-book-2.8.1.pdf](https://sourceforge.net/projects/veryquickwiki/files/veryquickwiki/2.8.1/vqwiki-book-2.8.1.pdf/download)
* <https://web.archive.org/web/20090430145310/http://www.vqwiki.org/> - one of the last snapshots ot the vqwiki.org site before the domain expired
* <https://tiddlywiki.com/>
