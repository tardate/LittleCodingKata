# SQL to CSV Output

Methods for generating CSV output from a PostgreSQL SQL query.

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

Often we'll want to snaffle some data from a PostgreSQL database in a [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) format
so that it can be used elsewhere. If you are programmatically connecting to a database then this is usually well supported by the
language in question and supporting libraries.

But to just get something from the command line using the standard tools?

That's also easy, using some SQL and [psql](https://www.postgresql.org/docs/current/app-psql.html) tricks.

This is a quick demonstration of three approaches:

* using psql formatting commands
* using the [COPY](https://www.postgresql.org/docs/current/sql-copy.html) SQL command
* using the [\copy](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-META-COMMANDS-COPY) psql meta command


### psql Formatting Commands

The format, fieldsep and footer options of the `\pset` meta command allow a result set to to formatted "like" CSV e.g.

```
\pset format unaligned
\pset fieldsep ','
\pset footer
select * from t1;
```

This produces output like this:

```
rank,name,speed_kmh,description
1,Peregrine falcon,389,Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h).
2,Golden eagle,320,Flight-diving
...
```

That might be good enough for simple data, but the results are not guaranteed to be well-formed CSV as it does not do any quoting of text - note all the ambiguous commas in the example above.

One area where this is very useful is for psql meta commands. These settings also affect the presentation of results from commands like `\d` e.g.

```
# \pset format unaligned
# \pset fieldsep ','
# \pset footer
# \d
List of relations
Schema,Name,Type,Owner
public,my_view,view,me
public,my_table,table,me
...
```

### The `COPY` SQL Command

PostgreSQL supports a [COPY](https://www.postgresql.org/docs/current/sql-copy.html) SQL command, with options to produce well-formed CSV, for example:

```
copy (
select * from t1
) to stdout with csv header delimiter ',';
```

Produces:

```
rank,name,speed_kmh,description
1,Peregrine falcon,389,"Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h)."
2,Golden eagle,320,Flight-diving
...
```

That works really well for echoing data to the console. If one wants the results to go into a file
the destination filename can be specified, for example: `.. to '/tmp/output.csv' .. `.

However, as a SQL command, this command actually runs on the database server, so the file is also on the database server. That may not be what you want.

### The psql `\copy` Meta Command

The psql utilitiy has a [\copy](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-META-COMMANDS-COPY) meta command
that accepts CSV options just like the COPY SQL command, however it runs local to the psql client.

Thus providing a file destination will create a local file, not a file on the database server.

```
\copy (select * from t1) to 'speedy.csv' with csv header delimiter ',';
```

Produces:
```
$ more speedy.csv
rank,name,speed_kmh,description
1,Peregrine falcon,389,"Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h)."
2,Golden eagle,320,Flight-diving
...
```

### Running the Example

The [sql2csv.sql](./sql2csv.sql) script demonstrates the different ways of generating CSV output,
using a test data set from [wikipedia](https://en.wikipedia.org/wiki/Fastest_animals).

The script creates a test database called `lck` and cleans this up after the test.
The only thing left behind is the [speedy.csv](./speedy.csv) output file.


```
$ psql postgres -f sql2csv.sql
>>> set some connection options
Pager usage is off.
>>> create a test database
CREATE DATABASE
You are now connected to database "lck" as user "paulgallagher".
>>> create test table and data
CREATE TABLE
INSERT 0 20
>>> the basic data in the test table:
 rank |              name               | speed_kmh |                                                                                                                                                                                                  description
------+---------------------------------+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    1 | Peregrine falcon                |       389 | Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h).
    2 | Golden eagle                    |       320 | Flight-diving
    3 | White-throated needletail swift |       169 | Flight
    4 | Eurasian hobby                  |       160 | Flight  Can sometimes outfly the swift
    5 | Mexican free-tailed bat         |       160 | Flight  It has been claimed to have the fastest horizontal speed (as opposed to stoop diving speed) of any animal.
    6 | Frigatebird                     |       153 | Flight  The frigatebird's high speed is helped by its having the largest wing-area-to-body-weight ratio of any bird.
    7 | Rock dove (pigeon)              |     148.9 | Flight: Pigeons have been clocked flying 92.5 mph (148.9 km/h) average speed on a 400-mile (640 km) race.
    8 | Spur-winged goose               |       142 | Flight
    9 | Black marlin                    |       129 | Swimming: A hooked black marlin has been recorded stripping line off a fishing reel at 120 feet per second (82 mph; 132 km/h).
   10 | Gyrfalcon                       |       128 | Flight
   11 | Grey-headed albatross           |       127 | Flight
   12 | Cheetah                         |     120.7 | Land  Fastest land-animal, fastest feline, the cheetah can accelerate from 0 to 96.6 km/h (60.0 mph) in under three seconds, though endurance is limited.
   13 | Sailfish                        |    109.19 | Flight-swimming
   14 | Anna's hummingbird              |     98.27 | Flight
   15 | Swordfish                       |        97 | Swimming
   16 | Pronghorn                       |      88.5 | Land
   17 | Springbok                       |        88 | Land
   18 | Blue wildebeest                 |      80.5 | Land
   19 | Lion                            |      80.5 | Land
   20 | Blackbuck                       |        80 | Land
(20 rows)

>>> using sql copy command to list as CSV:
rank,name,speed_kmh,description
1,Peregrine falcon,389,"Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h)."
2,Golden eagle,320,Flight-diving
3,White-throated needletail swift,169,Flight
4,Eurasian hobby,160,Flight  Can sometimes outfly the swift
5,Mexican free-tailed bat,160,Flight  It has been claimed to have the fastest horizontal speed (as opposed to stoop diving speed) of any animal.
6,Frigatebird,153,Flight  The frigatebird's high speed is helped by its having the largest wing-area-to-body-weight ratio of any bird.
7,Rock dove (pigeon),148.9,Flight: Pigeons have been clocked flying 92.5 mph (148.9 km/h) average speed on a 400-mile (640 km) race.
8,Spur-winged goose,142,Flight
9,Black marlin,129,Swimming: A hooked black marlin has been recorded stripping line off a fishing reel at 120 feet per second (82 mph; 132 km/h).
10,Gyrfalcon,128,Flight
11,Grey-headed albatross,127,Flight
12,Cheetah,120.7,"Land  Fastest land-animal, fastest feline, the cheetah can accelerate from 0 to 96.6 km/h (60.0 mph) in under three seconds, though endurance is limited."
13,Sailfish,109.19,Flight-swimming
14,Anna's hummingbird,98.27,Flight
15,Swordfish,97,Swimming
16,Pronghorn,88.5,Land
17,Springbok,88,Land
18,Blue wildebeest,80.5,Land
19,Lion,80.5,Land
20,Blackbuck,80,Land
>>> using psql copy command to export as local file speedy.csv:
COPY 20
>>> generating pseudo-CSV by fiddling psql settings:
Output format is unaligned.
Field separator is ",".
Default footer is off.
rank,name,speed_kmh,description
1,Peregrine falcon,389,Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h).
2,Golden eagle,320,Flight-diving
3,White-throated needletail swift,169,Flight
4,Eurasian hobby,160,Flight  Can sometimes outfly the swift
5,Mexican free-tailed bat,160,Flight  It has been claimed to have the fastest horizontal speed (as opposed to stoop diving speed) of any animal.
6,Frigatebird,153,Flight  The frigatebird's high speed is helped by its having the largest wing-area-to-body-weight ratio of any bird.
7,Rock dove (pigeon),148.9,Flight: Pigeons have been clocked flying 92.5 mph (148.9 km/h) average speed on a 400-mile (640 km) race.
8,Spur-winged goose,142,Flight
9,Black marlin,129,Swimming: A hooked black marlin has been recorded stripping line off a fishing reel at 120 feet per second (82 mph; 132 km/h).
10,Gyrfalcon,128,Flight
11,Grey-headed albatross,127,Flight
12,Cheetah,120.7,Land  Fastest land-animal, fastest feline, the cheetah can accelerate from 0 to 96.6 km/h (60.0 mph) in under three seconds, though endurance is limited.
13,Sailfish,109.19,Flight-swimming
14,Anna's hummingbird,98.27,Flight
15,Swordfish,97,Swimming
16,Pronghorn,88.5,Land
17,Springbok,88,Land
18,Blue wildebeest,80.5,Land
19,Lion,80.5,Land
20,Blackbuck,80,Land
>>> cleanup - drop everything we just created
DROP TABLE
You are now connected to database "postgres" as user "paulgallagher".
DROP DATABASE
```

## Credits and References

* [CSV](https://en.wikipedia.org/wiki/Comma-separated_values)
* [psql](https://www.postgresql.org/docs/current/app-psql.html)
* [\copy](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-META-COMMANDS-COPY)
* [COPY](https://www.postgresql.org/docs/current/sql-copy.html)
* [Fastest animals](https://en.wikipedia.org/wiki/Fastest_animals) - wikipedia
