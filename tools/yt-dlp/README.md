# #495 yt-dlp

About yt-dlp, a full featured command-line audio/video downloader

## Notes

I'm sure there are many legitimate (and legal) reasons for downloading videos.
Let's not get into that though, and just focus on *how*.

In the past I've used various tools such as [node-ytdl](https://www.npmjs.com/package/ytdl)
and [youtube-dl](https://github.com/ytdl-org/youtube-dl),
but at some point or other they break or can't handle certain situations.

More recently I've found [yt-dlp](https://github.com/yt-dlp/yt-dlp),
actually a fork of the [youtube-dl](https://github.com/ytdl-org/youtube-dl) python project.
It is actively maintained and so far has never let me down!

On macOS, it can easily be installed with [Homebrew](https://formulae.brew.sh/formula/yt-dlp):

```sh
brew install yt-dlp
```

There are a plethora of options to [learn about](https://github.com/yt-dlp/yt-dlp#readme),
but what I really appreciate are the preset aliases that are good for 99% of situations:

```sh
$ yt-dlp --help
...
  Preset Aliases:
    Predefined aliases for convenience and ease of use. Note that future versions of yt-dlp may add or adjust presets, but the existing preset names will not be
    changed or removed

    -t mp3                                                           -f 'ba[acodec^=mp3]/ba/b' -x --audio-format mp3

    -t aac                                                           -f 'ba[acodec^=aac]/ba[acodec^=mp4a.40.]/ba/b' -x --audio-format aac

    -t mp4                                                           --merge-output-format mp4 --remux-video mp4 -S vcodec:h264,lang,quality,res,fps,hdr:12,acodec:aac

    -t mkv                                                           --merge-output-format mkv --remux-video mkv

    -t sleep                                                         --sleep-subtitles 5 --sleep-requests 0.75 --sleep-interval 10 --max-sleep-interval 20

See full documentation at  https://github.com/yt-dlp/yt-dlp#readme
```

This makes downloading a Youtube video to mp4 as simple as:

```sh
$ yt-dlp -t mp4 dQw4w9WgXcQ
[youtube] Extracting URL: dQw4w9WgXcQ
[youtube] dQw4w9WgXcQ: Downloading webpage
[youtube] dQw4w9WgXcQ: Downloading tv samsung player API JSON
[youtube] dQw4w9WgXcQ: Downloading visionos player API JSON
[youtube] dQw4w9WgXcQ: Downloading player 6b3d0364-main
[youtube] [jsc:deno] Solving JS challenges using deno
[youtube] dQw4w9WgXcQ: Downloading m3u8 information
[info] dQw4w9WgXcQ: Downloading 1 format(s): 137+140
[download] Sleeping 4.00 seconds as required by the site...
[download] Destination: Rick Astley - Never Gonna Give You Up (Official Video) (4K Remaster) [dQw4w9WgXcQ].f137.mp4
[download] 100% of   77.16MiB in 00:00:08 at 8.76MiB/s
[download] Destination: Rick Astley - Never Gonna Give You Up (Official Video) (4K Remaster) [dQw4w9WgXcQ].f140.m4a
[download] 100% of    3.29MiB in 00:00:00 at 8.04MiB/s
[Merger] Merging formats into "Rick Astley - Never Gonna Give You Up (Official Video) (4K Remaster) [dQw4w9WgXcQ].mp4"
Deleting original file Rick Astley - Never Gonna Give You Up (Official Video) (4K Remaster) [dQw4w9WgXcQ].f137.mp4 (pass -k to keep)
Deleting original file Rick Astley - Never Gonna Give You Up (Official Video) (4K Remaster) [dQw4w9WgXcQ].f140.m4a (pass -k to keep)
[VideoRemuxer] Not remuxing media file "Rick Astley - Never Gonna Give You Up (Official Video) (4K Remaster) [dQw4w9WgXcQ].mp4"; already is in target format mp4
```

## Credits and References

* <https://github.com/yt-dlp/yt-dlp>
* <https://formulae.brew.sh/formula/yt-dlp>
* <https://github.com/ytdl-org/youtube-dl>
* <https://www.npmjs.com/package/ytdl>
