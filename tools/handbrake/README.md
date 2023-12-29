# HandBrake

Installing HandBrake on macOS Sonoma for ripping copy-protected DVDs. Long live physical media!

## Notes

Handrake is the application I've trusted for many years to do my DVD ripping on macOS.
Why rip? Because machines don't come with DVD drives any more, so I rip once and then play from the digital copy. Long live physical media!

I'm setting up fresh on macOS Sonoma (Apple Silicon M3), using `HandBrake-1.7.2.dmg` from 
[HandBrake](https://handbrake.fr/)

### Installing libdvdcss

HandBrake can't rip copy-protected disks by default.
This can be fixed by installing [libdvdcss](https://en.wikipedia.org/wiki/Libdvdcss)
as [explained here](https://www.reddit.com/r/handbrake/comments/t60dd7/problem_using_151_on_m1_mba/?rdt=33634)

The easiest way to install libdvdcss is with HomeBrew:

    $ brew install libdvdcss
    ==> Downloading https://formulae.brew.sh/api/formula.jws.json
    ############################################################################################################################################################################# 100.0%
    ==> Downloading https://formulae.brew.sh/api/cask.jws.json
    ############################################################################################################################################################################# 100.0%
    ==> Downloading https://ghcr.io/v2/homebrew/core/libdvdcss/manifests/1.4.3
    ############################################################################################################################################################################# 100.0%
    ==> Fetching libdvdcss
    ==> Downloading https://ghcr.io/v2/homebrew/core/libdvdcss/blobs/sha256:a88500318685760e0425a099d0459f7be9f7505b89e69785af9d7ae183e40541
    ############################################################################################################################################################################# 100.0%
    ==> Pouring libdvdcss--1.4.3.arm64_sonoma.bottle.tar.gz
    🍺  /opt/homebrew/Cellar/libdvdcss/1.4.3: 18 files, 403.9KB
    ==> Running `brew cleanup libdvdcss`...
    Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
    Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

### Making libdvdcss available to HandBrake

HandBrake can't find the library in the HomeBrew installation location
`/opt/homebrew/Cellar/libdvdcss/1.4.3`, as it is looking in `/usr/local/lib/`.

The solution is to copy over the required library:

    $ sudo cp /opt/homebrew/Cellar/libdvdcss/1.4.3/lib/libdvdcss.2.dylib /usr/local/lib
    $ ls -al /usr/local/lib
    total 144
    drwxr-xr-x  3 root  wheel     96 Dec 29 19:19 .
    drwxr-xr-x  4 root  wheel    128 Dec 29 19:07 ..
    -rw-r--r--  1 root  wheel  72480 Dec 29 19:19 libdvdcss.2.dylib

When ripping with HomeBrew, the activity window will confirm that the library is found:

    ...
    [19:20:24] macgui: ScanCore library found for decrypting physical disc
    ...


Note: unfortunately, we can't use symlinks. I tried this first:

    $ sudo ln -s /opt/homebrew/Cellar/libdvdcss/1.4.3/lib/libdvdcss.2.dylib /usr/local/lib/libdvdcss.2.dylib

But the operating system sandbox comes down hard:

    [19:09:42] macgui: dlopen error: dlopen(/usr/local/lib/libdvdcss.2.dylib, 0x0001): tried: '/usr/local/lib/libdvdcss.2.dylib' (file system sandbox blocked open()), '/System/Volumes/Preboot/Cryptexes/OS/usr/local/lib/libdvdcss.2.dylib' (no such file), '/usr/local/lib/libdvdcss.2.dylib' (file system sandbox blocked open())

More info: [mac OS file system sandbox blocked open()](https://stackoverflow.com/questions/44627957/mac-os-file-system-sandbox-blocked-open)

## Credits and References

* [HandBrake](https://handbrake.fr/)
* [libdvdcss](https://en.wikipedia.org/wiki/Libdvdcss)
* [Problem using 1.5.1 on M1 MBA](https://www.reddit.com/r/handbrake/comments/t60dd7/problem_using_151_on_m1_mba/?rdt=33634)
* [mac OS file system sandbox blocked open()](https://stackoverflow.com/questions/44627957/mac-os-file-system-sandbox-blocked-open)
