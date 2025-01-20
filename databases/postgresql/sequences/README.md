# #268 PostgreSQL Sequences

Notes on managing PostgreSQL Sequences

## Notes

### Running the Example

The [sequences.sql](./sequences.sql) script demonstrates ..

The script creates a test database called `lck` and cleans this up after the test.

```
$ psql postgres -f sequences.sql
>>> set some connection options
Pager usage is off.
>>> create a test database
CREATE DATABASE
You are now connected to database "lck" as user "paulgallagher".
>>> explicit sequences
CREATE TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
                                       Table "public.t1"
 Column |         Type          | Collation | Nullable |                Default
--------+-----------------------+-----------+----------+---------------------------------------
 id     | integer               |           | not null | nextval('t1_custom_id_seq'::regclass)
 name   | character varying(20) |           |          |

 pg_get_serial_sequence
-------------------------
 public.t1_custom_id_seq
(1 row)

INSERT 0 3
 id |  name
----+--------
  1 | t1.1.1
  2 | t1.1.2
  3 | t1.1.3
(3 rows)

DELETE 1
 setval
--------
      2
(1 row)

INSERT 0 1
 id |  name
----+--------
  1 | t1.1.1
  2 | t1.1.2
  3 | t1.2.3
(3 rows)

DELETE 1
 setval
--------
      2
(1 row)

INSERT 0 1
 id |  name
----+--------
  1 | t1.1.1
  2 | t1.1.2
  3 | t1.3.3
(3 rows)

TRUNCATE TABLE
 setval
--------

(1 row)

INSERT 0 1
 id |  name
----+--------
  4 | t1.4.1
(1 row)

TRUNCATE TABLE
ALTER SEQUENCE
INSERT 0 1
 id |  name
----+--------
  1 | t1.5.1
(1 row)

TRUNCATE TABLE
 setval
--------
      1
(1 row)

INSERT 0 3
 id |  name
----+--------
  1 | t1.6.1
  2 | t1.6.2
  3 | t1.6.3
(3 rows)

DELETE 1
 setval
--------
      3
(1 row)

INSERT 0 1
 id |  name
----+--------
  1 | t1.6.1
  2 | t1.6.2
  3 | t1.7.3
(3 rows)

>>> serial columns
CREATE TABLE
                                   Table "public.t2"
 Column |         Type          | Collation | Nullable |            Default
--------+-----------------------+-----------+----------+--------------------------------
 id     | integer               |           | not null | nextval('t2_id_seq'::regclass)
 name   | character varying(20) |           |          |

 pg_get_serial_sequence
------------------------
 public.t2_id_seq
(1 row)

INSERT 0 3
 id |  name
----+--------
  1 | t2.1.1
  2 | t2.1.2
  3 | t2.1.3
(3 rows)

DELETE 1
 setval
--------
      4
(1 row)

INSERT 0 1
 id |  name
----+--------
  1 | t2.1.1
  2 | t2.1.2
  4 | t2.2.3
(3 rows)

>>> cleanup - drop everything we just created
DROP TABLE
DROP TABLE
You are now connected to database "postgres" as user "paulgallagher".
DROP DATABASE
```

## Credits and References

* [How to reset Postgres' primary key sequence when it falls out of sync?](https://stackoverflow.com/questions/244243/how-to-reset-postgres-primary-key-sequence-when-it-falls-out-of-sync)
* [9.17. Sequence Manipulation Functions](https://www.postgresql.org/docs/15/functions-sequence.html)
* [CREATE SEQUENCE](https://www.postgresql.org/docs/15/sql-createsequence.html)
