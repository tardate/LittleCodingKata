# #xxx List Manipulation with Prolog

Using Prolog to reverse, sort, and find the minimum of a list.

## Notes

This is an exercise from [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/).

The task:

* Reverse the elements of a list.
* Find the smallest element of a list.
* Sort the elements of a list.

## About Lists in Prolog

Lists and tuples are a big part of Prolog.

* lists are containers of variable length, specified like: `[1, 2, 3]`
* tuples are containers with a fixed length, specified as `(1, 2, 3)`

When Prolog tries to unify variables, it tries to make both the
left and right sides match

```prolog
$ gprolog
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

| ?- [1, 2, 3] = [X, Y, Z].

X = 1
Y = 2
Z = 3

yes
| ?- [2, 2, 3] = [X, X, Z].

X = 2
Z = 3

yes
```

You can deconstruct lists with `[Head|Tail]`.
`Head` will bind to the first element of the list, and Tail will bind to the rest:

```prolog
| ?- [a, b, c] = [Head|Tail].

Head = a
Tail = [b,c]

yes
```

## Reverse the elements of a list

GNU Prolof has a built-in predicate for reversing a list - [reverse](http://www.gprolog.org/manual/gprolog.html#sec212):

```prolog
| ?- reverse([a,b,c,d,e,f], Result).

Result = [f,e,d,c,b,a]

yes
```

But let's do it by hand with a recursive rule, see [reverse_list.pl](./reverse_list.pl):

```prolog
reverse_list([], []).
reverse_list([Head|Tail], Reversed) :-
    reverse_list(Tail, ReversedTail),
    append(ReversedTail, [Head], Reversed).

```

Loading the program:

```sh
$ gprolog --consult-file reverse_list.pl
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

compiling ./reverse_list.pl for byte code...
./reverse_list.pl compiled, 4 lines read - 769 bytes written, 3 ms
```

Reversing a list. Looks good:

```prolog
| ?- reverse_list([1,2,3,4,5,6,7,8,9], Result).

Result = [9,8,7,6,5,4,3,2,1]

yes
```

Demonstrating it is not just numbers:

```prolog
| ?- reverse_list([a,b,c,d,e,f], Result).

Result = [f,e,d,c,b,a]

yes
```

Demonstrating it is not a numeric sort:

```prolog
| ?- reverse_list([11,99,22,88,33,77,44,66,55], Result).

Result = [55,66,44,77,33,88,22,99,11]

yes
```

## Find the smallest element of a list

GNU Prolog has a built in predicate - [min_list](http://www.gprolog.org/manual/html_node/gprolog044.html#sec222):

```sh
$ gprolog
| ?- min_list([1,2,3], X).

X = 1

yes
```

But we can also do this by declaring a recursive rule, see [minimum_list.pl](./minimum_list.pl).
The cut (!) means "do not backtrack past this point":

```prolog
minimum_list([X], X) :- !.
minimum_list([Head|Tail], Min) :-
    minimum_list(Tail, TailMin),
    ( Head < TailMin -> Min = Head ; Min = TailMin ),
    !.
```

Testing it out:

```sh
$ gprolog --consult-file minimum_list.pl
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz

compiling ./minimum_list.pl for byte code...
./minimum_list.pl compiled, 4 lines read - 1292 bytes written, 3 ms
```

Testing it out:

```prolog
| ?- minimum_list([2,3,4], Result).

Result = 2

yes
| ?- minimum_list([7,3,4], Result).

Result = 3

yes
| ?- minimum_list([4], Result).

Result = 4

yes
```

## Sort the elements of a list

Again, GNU Prolog has built-in predicates, see [sort/2, msort/2, keysort/2 sort/1, msort/1, keysort/1](http://www.gprolog.org/manual/gprolog.html#sort%2F2):

```sh
$ gprolog
GNU Prolog 1.5.0 (64 bits)
Compiled Jul  8 2021, 09:35:47 with clang
Copyright (C) 1999-2024 Daniel Diaz
| ?- sort([6,3,7], Result).

Result = [3,6,7]

yes
```

But we can also do this by declaring a recursive rule, see [sort_list.pl](./sort_list.pl):

```prolog
sort_list([],[]) :- !.
sort_list([A],[A]) :- !.
sort_list([A,B|R],S) :-
  split([A,B|R],L1,L2),
  sort_list(L1,S1),
  sort_list(L2,S2),
  merge(S1,S2,S),
  !.
split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|Ra],[B|Rb]) :- split(R,Ra,Rb).
merge(A,[],A).
merge([],B,B).
merge([A|Ra],[B|Rb],[A|M]) :- A =< B, merge(Ra,[B|Rb],M).
merge([A|Ra],[B|Rb],[B|M]) :- A > B, merge([A|Ra],Rb,M).
```

Testing it out:

```prolog
| ?- sort_list([6,3,7], Result).

Result = [3,6,7]

yes
| ?- sort_list([1,2,3,4,9,8,7,6,5], Result).

Result = [1,2,3,4,5,6,7,8,9]

yes
```

## Credits and References

* [Seven Languages in Seven Weeks](../../books/seven-languages-in-seven-weeks/) - Chapter 4: Prolog
* [reverse](http://www.gprolog.org/manual/gprolog.html#sec212)
* [min_list](http://www.gprolog.org/manual/html_node/gprolog044.html#sec222)
