# Running Emacs

Time to try Emacs - up and running on MacOS.

## Notes

I've probably used dozens of editors over the years, Emacs is not one of them - perhaps time to change that.

I was prompted in particular by DistroTube's "Switching to GNU Emacs" video:

[![example](https://img.youtube.com/vi/Y8koAgkBEnM/0.jpg)](https://www.youtube.com/watch?v=Y8koAgkBEnM)

## Installing on MacOS

I just did the [homebrew](http://brew.sh/) install:

    brew cask install emacs
    ==> Downloading https://emacsformacosx.com/emacs-builds/Emacs-26.3-universal.dmg
    ==> Downloading from https://emacsformacosx.com/download/emacs-builds/Emacs-26.3-universal.dmg
    ######################################################################## 100.0%
    ==> Verifying SHA-256 checksum for Cask 'emacs'.
    ==> Installing Cask emacs
    ==> Moving App 'Emacs.app' to '/Applications/Emacs.app'.
    ==> Linking Binary 'Emacs' to '/usr/local/bin/emacs'.
    ==> Linking Binary 'ebrowse' to '/usr/local/bin/ebrowse'.
    ==> Linking Binary 'emacsclient' to '/usr/local/bin/emacsclient'.
    ==> Linking Binary 'etags' to '/usr/local/bin/etags'.
    🍺  emacs was successfully installed!

## Firing Up With Some Customisations

![editing](./assets/editing.png?raw=true)

## Emoji/Emoticons

When I viewed this file in Emacs, the first thing I noticed is it did't display the brew (🍺) emoticon above.

Found a [reddit](https://www.reddit.com/r/emacs/comments/3srete/display_emojis_in_emacs/) thread but not solved that yet.

## Verical Editing

One of the more common things I'll do is edit multiple lines simultaneously with vertical blocks.

Hmm, it seems with Emacs it is kind of possible, but very klunky, according to
[Emacs: Edit Column Text, Rectangle Commands](http://ergoemacs.org/emacs/emacs_string-rectangle_ascii-art.html).

See also [Rectangles](https://www.gnu.org/software/emacs/manual/html_node/emacs/Rectangles.html) in the manual.

### Character Input Shortcuts

I commonly use Alt-<key> for special character input e.g. "Ω µ √".
Since Alt is the default Emacs "META" key, [that's a problem](https://www.emacswiki.org/emacs/MetaKeyProblems).

The only solution seems to be to [map the meta key to another key](https://stackoverflow.com/a/35661545/6329)
e.g. the fn key. I switch, and now I have my œ∑´®†© chars back!

    $ cat ~/.emacs
    (setq mac-function-modifier 'meta)
    (setq mac-option-modifier nil)


### Other Observations

* File load is really slow? Like a second or so for this markdown file to open. Once in the file, performance is fine.
* The way the windo contents blank when resizing the window is really klunky (90's GUI feel)

### Conclusion

Having taken a look at the Emacs ecosystem I can understand why people like it.

Is Emacs for me? I quickly ran into a few things I take for granted in my editor that didn't all have easy solutions,
and it looks like the learning curve would be pretty steep since most of the ingrained keystrokes combos in my head are vi/m-style.

Add to that the fact that "improving my productivity in a text editor" is not even a top 100 goal, then I think not. For now at least.


## Credits and References

* [Emacs](https://www.gnu.org/software/emacs/)
* [Emacs](https://en.wikipedia.org/wiki/Emacs) - wikipedia
