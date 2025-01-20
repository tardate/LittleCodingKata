# #303 ID3 Tags

Managing ID3 tags with Ruby.

## Notes

ID3 tags are metadata containers embedded in audio files, primarily MP3s, that store information about the track. This data can include the song title, artist, album, track number, genre, and more. ID3 tags allow media players to display this information, making it easier for users to organize and identify songs without referring to the file name.

ID3 tags come in two primary versions: ID3v1 and ID3v2. The ID3v2 tag is more commonly used today because of its support for additional data.

* ID3v1
    * Fixed size, limited to basic fields like title, artist, album, and genre.
* ID3v2
    * More flexible and supports extended data such as album artwork, lyrics, and custom metadata.

For more information, refer to the [ID3 website](https://id3.org/).

### Ruby Libraries

There are a number of [Ruby ID3 tag libraries](https://rubygems.org/search?query=id3),
but I quickly narrowed down those of interest to just two:

* <https://rubygems.org/gems/id3tag> - one of the most widely used and reasonably well maintained. The main disadvantage of this gem is that in can only read tags, not write them.
* <https://rubygems.org/gems/id3taginator> - while not widely used, it is relatively new and well maintained, and also supports writing tags.

I did look at others, but most were rejected because they were poorly maintained and/or required external libraries.

### Using `id3tag`

The [id3tag](https://github.com/krists/id3tag) gem
is a native Ruby ID3 tag library that aims for 100% coverage of ID3v2.x and ID3v1.x standards.

```sh
$ ./read_with_id3tag.rb sample_data/custom.mp3
Filename: sample_data/custom.mp3
Title: Overview of the People's Liberation Army Navy (PLAN)
Artist: AI
Album: My Briefings
```

### Using `id3taginator`

The [Id3Taginator](https://github.com/cfe86/Id3Taginator) gem is an ID3v1, ID3v2.2/3/4 tag reader and writer fully written in Ruby and does not rely on TagLib or any other 3rd party library to read/write id3tags. It aims to offer a simple way to read and write ID3Tags.

The [id3tagger.rb](./id3tagger.rb) script is a simple demonstration using [Id3Taginator](https://github.com/cfe86/Id3Taginator).
It can perform most required operations on ID3 tags:

```sh
$ ./id3tagger.rb -h
Usage: id3tagger.rb [options] file
    -s, --show                       Show the ID3 tags
    -u, --update                     Update the ID3 tags
    -r, --remove                     Remove ID3 tags
    -C, --create VERSION             Create ID3 tag VERSION=1 or 2
    -a, --artist=ARTIST              Specify the artists (v1: text, v2: CSV list)
    -t, --title=TITLE                Specify the title
    -A, --album=ALBUM                Specify the album name
    -y, --year=YEAR                  (v2 only) Specify the year
    -g, --genre=GENRE                (v2 only) Specify genres as CSV list
    -c, --comment=COMMENT            (v2 only) Specify an English comment as '<descriptor>,<comment>'. If '<comment>' is blank, will remove comment for the descriptor
```

#### Example Usage

Showing v1 tags:

```sh
$ ./id3tagger.rb data/v1tags.mp3 -s
Title: title
Artist: artist name
Album: album name name
```

Showing v2 tags:

```sh
$ ./id3tagger.rb data/v2tags.mp3 -s
Title: Sample Title
Album: Album Name
Year: 2024
Artists:
 - Artist Name
Genres:
 - AI
Comments:
 - rating: 5 stars
```

Showing untagged file:

```sh
$ ./id3tagger.rb data/untagged.mp3 -s
No ID3 tags found.
```

Clearing and re-creating v2 tags:

```sh
$ cp data/v1tags.mp3 data/test.mp3
$ ./id3tagger.rb data/test.mp3 -s
Title: title
Artist: artist name
Album: album name name
$ ./id3tagger.rb data/test.mp3 -r
Removed all ID3 tags.
$ ./id3tagger.rb data/test.mp3 -s
No ID3 tags found.
$ ./id3tagger.rb data/test.mp3 -C2
Created ID3 tags version 2.3.
$ ./id3tagger.rb data/test.mp3 -s
Title: null
Album: null
Year: null
Artists:
Genres:
Comments:
$ ./id3tagger.rb data/test.mp3 -u -t "new title"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -u -a "new artist"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -u -A "new album name"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -u -y "2024"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -u -g "Test,Audiobook"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -s
Title: new title
Album: new album name
Year: 2024
Artists:
 - new artist
Genres:
 - Test
 - Audiobook
Comments:
```

Adding comments: this requires a descriptor and a comment as a CSV list

```sh
$ ./id3tagger.rb data/test.mp3 -u -c "rating,3.5 stars"
descriptor:rating, comment:3.5 stars
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -s
Title: new title
Album: new album name
Year: 2024
Artists:
 - new artist
Genres:
 - Test
 - Audiobook
Comments:
 - rating: 3.5 stars
$ ./id3tagger.rb data/test.mp3 -u -c "language,English"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -s
Title: new title
Album: new album name
Year: 2024
Artists:
 - new artist
Genres:
 - Test
 - Audiobook
Comments:
 - rating: 3.5 stars
 - language: English
```

Updating comment: re-using a descriptor will cause it to be updated

```sh
$ ./id3tagger.rb data/test.mp3 -u -c "rating,5 stars"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -s
Title: new title
Album: new album name
Year: 2024
Artists:
 - new artist
Genres:
 - Test
 - Audiobook
Comments:
 - rating: 5 stars
 - language: English
```

Removing comment: this is done by just providing the descriptor, but not a comment.

```sh
$ ./id3tagger.rb data/test.mp3 -u -c "language"
ID3v2 tags updated successfully.
$ ./id3tagger.rb data/test.mp3 -s
Title: new title
Album: new album name
Year: 2024
Artists:
 - new artist
Genres:
 - Test
 - Audiobook
Comments:
 - rating: 5 stars
```

## Credits and References

* [ID3 website](https://id3.org/)
* [Ruby id3tag gem](https://rubygems.org/gems/id3tag)
* [Ruby Id3Taginator gem](https://rubygems.org/gems/id3taginator)
