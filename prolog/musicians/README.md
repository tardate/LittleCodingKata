# #387 Musicians with Prolog

Using Prolog to represent and query a knowledge base representing musicians and instruments.

## Notes

This is an exercise from [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

The task:

* Make a knowledge base representing musicians and instruments. Also
represent musicians and their genre of music.
* Find all musicians who play the guitar.

## Thinking about the Problem

This is a fairly straight-forward problem:

* we just need to record facts directly about each musician: the instrument(s) and genre(s)
* we are only making basic and direct queries about the facts

## Implementation

See [musicians.pl](./musicians.pl).
It defines the instrument(s) that a musicians `plays`, and the `genre`.
For example, a small extract:

```prolog
genre(ella_fitzgerald, jazz).
genre(elton_john, pop_rock).
plays(ella_fitzgerald, vocals).
plays(elton_john, piano).
plays(elton_john, vocals).
```

## Some Queries

Loading the program:

```sh
$ gprolog --consult-file musicians.pl
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

compiling ./musicians.pl for byte code...
./musicians.pl compiled, 34 lines read - 3980 bytes written, 4 ms
```

Query to find all musicians who play the guitar:

```prolog
| ?- plays(Musician, guitar).

Musician = bb_king ? ;

Musician = eric_clapton ? ;

Musician = jimi_hendrix ? ;

Musician = ritchie_blackmore

yes
```

Query to find all jazz musicians:

```prolog
| ?- genre(Musician, jazz).

Musician = billie_holiday ? ;

Musician = charlie_parker ? ;

Musician = dave_brubeck ? ;

Musician = ella_fitzgerald ? ;

Musician = herbie_hancock ? ;

Musician = john_coltrane ? ;

Musician = louis_armstrong ? ;

Musician = miles_davis ? ;

(1 ms) no
```

## Credits and References

* [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/) - Chapter 4: Prolog
