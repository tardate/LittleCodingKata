# #039 Copying Tables

Notes on copying table strictures and data with SQL.

## Notes

Source table used for the examples:

```
lck=# \d source_table
                                      Table "public.source_table"
   Column    |          Type          | Collation | Nullable |                 Default
-------------+------------------------+-----------+----------+------------------------------------------
 id          | integer                |           | not null | nextval('source_table_id_seq'::regclass)
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          | 0
 description | character varying(500) |           |          |
Indexes:
    "source_table_pkey" PRIMARY KEY, btree (id)

lck=# select count(*) from source_table;
 count
-------
    20
(1 row)
```

### Create From Select

[CREATE TABLE AS](https://www.postgresql.org/docs/9.6/sql-createtableas.html)
can be used to create a new table from an existing table, with or without data:

`CREATE TABLE copied_structure AS SELECT * FROM source_table WITH [NO] DATA;`

This doesn't copy table defaults, constraints indexs, storage or comments.

Example:

```
lck=# CREATE TABLE copied_structure AS SELECT * FROM source_table WITH NO DATA;
CREATE TABLE AS
lck=# \d copied_structure
                    Table "public.copied_structure"
   Column    |          Type          | Collation | Nullable | Default
-------------+------------------------+-----------+----------+---------
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          |
 description | character varying(500) |           |          |

lck=# select count(*) from copied_structure;
 count
-------
     0
(1 row)

lck=# CREATE TABLE copied_data AS SELECT * FROM source_table limit 3;
CREATE TABLE AS
lck=# \d copied_data
                      Table "public.copied_data"
   Column    |          Type          | Collation | Nullable | Default
-------------+------------------------+-----------+----------+---------
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          |
 description | character varying(500) |           |          |

lck=# select count(*) from copied_data;
 count
-------
     3
(1 row)
```

### Create Like

[CREATE TABLE](https://www.postgresql.org/docs/9.6/sql-createtable.html)
supports a `LIKE` clause that can be used to copy a table,
optionally including defaults, constraints indexs, storage and comments.

```
lck=# CREATE TABLE like_structure ( LIKE source_table INCLUDING ALL );
CREATE TABLE
lck=# \d like_structure
                                     Table "public.like_structure"
   Column    |          Type          | Collation | Nullable |                 Default
-------------+------------------------+-----------+----------+------------------------------------------
 id          | integer                |           | not null | nextval('source_table_id_seq'::regclass)
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          | 0
 description | character varying(500) |           |          |
Indexes:
    "like_structure_pkey" PRIMARY KEY, btree (id)

lck=# select count(*) from like_structure;
 count
-------
     0
(1 row)
```

### Using Create Like to Modify Tables 'offline'

Significant structural or indexing changes can sometimes be difficult to apply on production tables.
One approach is to do the switcheroo:

* create a new table like the existing one
* apply any new indexes or constraints
* insert data from old table to new
* drop the old table (or rename it). May require taking care of object ownerships.
* rename the new table to the new table


### Running Full Example

The [demo.sql](./demo.sql) script demonstrates the different ways of generating CSV output,
using a test data set from [wikipedia](https://en.wikipedia.org/wiki/Fastest_animals).

The script creates a test database called `lck` and cleans this up after the test.

```
$ psql postgres -f demo.sql
>>> set some connection options
Pager usage is off.
>>> create a test database
CREATE DATABASE
You are now connected to database "lck" as user "paulgallagher".
>>> create test table and data
CREATE TABLE
INSERT 0 20
>>>>> the structure and data in the test table:
                                      Table "public.source_table"
   Column    |          Type          | Collation | Nullable |                 Default
-------------+------------------------+-----------+----------+------------------------------------------
 id          | integer                |           | not null | nextval('source_table_id_seq'::regclass)
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          | 0
 description | character varying(500) |           |          |
Indexes:
    "source_table_pkey" PRIMARY KEY, btree (id)

 id | rank |              name               | speed_kmh |                                                                                                                                                                                                  description
----+------+---------------------------------+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  1 |    1 | Peregrine falcon                |       389 | Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h).
  2 |    2 | Golden eagle                    |       320 | Flight-diving
  3 |    3 | White-throated needletail swift |       169 | Flight
  4 |    4 | Eurasian hobby                  |       160 | Flight  Can sometimes outfly the swift
  5 |    5 | Mexican free-tailed bat         |       160 | Flight  It has been claimed to have the fastest horizontal speed (as opposed to stoop diving speed) of any animal.
  6 |    6 | Frigatebird                     |       153 | Flight  The frigatebird's high speed is helped by its having the largest wing-area-to-body-weight ratio of any bird.
  7 |    7 | Rock dove (pigeon)              |     148.9 | Flight: Pigeons have been clocked flying 92.5 mph (148.9 km/h) average speed on a 400-mile (640 km) race.
  8 |    8 | Spur-winged goose               |       142 | Flight
  9 |    9 | Black marlin                    |       129 | Swimming: A hooked black marlin has been recorded stripping line off a fishing reel at 120 feet per second (82 mph; 132 km/h).
 10 |   10 | Gyrfalcon                       |       128 | Flight
 11 |   11 | Grey-headed albatross           |       127 | Flight
 12 |   12 | Cheetah                         |     120.7 | Land  Fastest land-animal, fastest feline, the cheetah can accelerate from 0 to 96.6 km/h (60.0 mph) in under three seconds, though endurance is limited.
 13 |   13 | Sailfish                        |    109.19 | Flight-swimming
 14 |   14 | Anna's hummingbird              |     98.27 | Flight
 15 |   15 | Swordfish                       |        97 | Swimming
 16 |   16 | Pronghorn                       |      88.5 | Land
 17 |   17 | Springbok                       |        88 | Land
 18 |   18 | Blue wildebeest                 |      80.5 | Land
 19 |   19 | Lion                            |      80.5 | Land
 20 |   20 | Blackbuck                       |        80 | Land
(20 rows)

>>> using create as with no data:
CREATE TABLE AS
>>>>> created structure and content:
                    Table "public.copied_structure"
   Column    |          Type          | Collation | Nullable | Default
-------------+------------------------+-----------+----------+---------
 id          | integer                |           |          |
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          |
 description | character varying(500) |           |          |

 count
-------
     0
(1 row)

>>> using create as with no data:
SELECT 3
>>>>> created structure and content:
                      Table "public.copied_data"
   Column    |          Type          | Collation | Nullable | Default
-------------+------------------------+-----------+----------+---------
 id          | integer                |           |          |
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          |
 description | character varying(500) |           |          |

 count
-------
     3
(1 row)

>>> using create like:
CREATE TABLE
>>>>> created structure and content:
                                     Table "public.like_structure"
   Column    |          Type          | Collation | Nullable |                 Default
-------------+------------------------+-----------+----------+------------------------------------------
 id          | integer                |           | not null | nextval('source_table_id_seq'::regclass)
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          | 0
 description | character varying(500) |           |          |
Indexes:
    "like_structure_pkey" PRIMARY KEY, btree (id)

 count
-------
     0
(1 row)

>>> demonstrate a table switch and patch:
CREATE TABLE
>>>>> add a new index to new_source_table:
CREATE INDEX
>>>>> copy over the data:
INSERT 0 20
>>>>> maybe a good idea to vacuum analyze:
VACUUM
>>>>> drop the old table and switch names:
ALTER SEQUENCE
DROP TABLE
ALTER TABLE
>>>>> new source table structure and data:
                                      Table "public.source_table"
   Column    |          Type          | Collation | Nullable |                 Default
-------------+------------------------+-----------+----------+------------------------------------------
 id          | integer                |           | not null | nextval('source_table_id_seq'::regclass)
 rank        | integer                |           |          |
 name        | character varying(60)  |           |          |
 speed_kmh   | numeric                |           |          | 0
 description | character varying(500) |           |          |
Indexes:
    "new_source_table_pkey" PRIMARY KEY, btree (id)
    "new_source_table_index" btree (rank, name)

                Sequence "public.source_table_id_seq"
  Type   | Start | Minimum |  Maximum   | Increment | Cycles? | Cache
---------+-------+---------+------------+-----------+---------+-------
 integer |     1 |       1 | 2147483647 |         1 | no      |     1
Owned by: public.source_table.id

 count
-------
    20
(1 row)

>>> cleanup - drop everything we just created
DROP TABLE
DROP TABLE
DROP TABLE
DROP TABLE
You are now connected to database "postgres" as user "paulgallagher".
DROP DATABASE
```

## Credits and References

* [CREATE TABLE AS](https://www.postgresql.org/docs/9.6/sql-createtableas.html)
* [CREATE TABLE](https://www.postgresql.org/docs/9.6/sql-createtable.html)
* [ALTER TABLE](https://www.postgresql.org/docs/9.6/sql-altertable.html)
