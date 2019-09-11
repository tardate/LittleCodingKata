# Implementing a Dictionary

An example of using struct-based C to implement a somewhat object-oriented dictionary.

## Notes

This is based on an example from
[21st Century C](https://www.goodreads.com/book/show/14514281-21st-century-c)
Chapter 11: Object-Oriented Programming in C, Implementing a Dictionary, p210.

It is not intended to be ready for prime-time; this problem has been solved before
and there a re reliable implementations available such as
[GHashTable](https://developer.gnome.org/glib/stable/glib-Hash-Tables.html).

A dictionary (aka hash table) is an easy structure to generate, given what we have in struct-based C.
It represents associations between keys and values so that given a key the value can be found quickly.

### Design

`keyval.{h,c}` implements the core key-value data structure and some supporting manipulation methods.
It just stores the name and a pointer to the value:

    typedef struct keyval {
       char *key;
       void *value;
    } keyval;

`dict.{h,c}` is the dictionary implementation. It holds the list of `keyval` and keeps track of the list length:

    typedef struct dictionary {
       keyval **pairs;
       int length;
    } dictionary;


`dict_use.c` demonstrates the use. The basics:

    int zero = 0;
    dictionary *d = dictionary_new();
    dictionary_add(d, "an int", &zero);
    printf("The integer I recorded was: %i\n", *(int*)dictionary_find(d, "an int"));

### Building with Make

I've added a Makefile that builds the project with minimal fuss. It produces two binaries: `dict_test` and `dict_use`.

    $ make all
    $ ./dict_test
    /set1/new test: OK
    /set1/copy test: OK
    /set2/fail test: OK
    $ ./dict_use
    Finding: 'key1' (int)    .. found: 1
    Finding: 'key2' (float)  .. found: 2.000000
    Finding: 'key3' (string) .. found: three
    Finding: 'bogative'      .. not found


### Building with Automake

The `build_with_automake.sh` script wraps up the commands to build with Automake. This will copy and re-generate the project in a sub-folder called `hash`
    $ ./build_with_automake.sh
    ...
    ...
    ALL DONE! Trying it out...
    The integer I recorded was: 0
    The string was: two


## Credits and References

* [21st Century C](https://www.goodreads.com/book/show/14514281-21st-century-c)
* [GHashTable](https://developer.gnome.org/glib/stable/glib-Hash-Tables.html)
