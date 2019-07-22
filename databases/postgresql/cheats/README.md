# PostgreSQL Cheat Sheet

Basic administration and data management command tips and tricks...

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes


## Managing Roles

### Connection limit per user

Use the [pg_roles](https://www.postgresql.org/docs/9.3/view-pg-roles.html) view.

```
SELECT rolname, rolconnlimit
FROM pg_roles
WHERE rolconnlimit <> -1;
```


## Analyzing the Schema

### Approximate Row Counts

Using `count(*)` to get row counts is notoriously poor performing in a busy database.
If approximate row counts are satisfactory, `pg_stat_user_tables` and `pg_stat_all_tables` statistics views provide a fast alternative.

See also:

* [How do you find the row count for all your tables in Postgres](http://stackoverflow.com/questions/2596670/how-do-you-find-the-row-count-for-all-your-tables-in-postgres)
* [Standard Statistics Views](https://www.postgresql.org/docs/9.3/monitoring-stats.html)
* `n_live_tup` (bigint) - Estimated number of live rows
* `n_dead_tup` (bigint) - Estimated number of dead rows

Basic example:

```
SELECT schemaname,relname,n_live_tup
FROM pg_stat_user_tables -- or pg_stat_all_tables
ORDER BY n_live_tup DESC;

 schemaname |             relname              | n_live_tup
------------+----------------------------------+------------
 myschema   | sessions                         | 1349078582
 myschema   | schema_migrations                |        157
 myschema   | users                            |         15
```

Or with more details:

```
SELECT
  relname,n_live_tup,n_dead_tup,
  -- seq_scan, seq_tup_read,idx_scan,idx_tup_fetch,n_tup_ins,n_tup_upd,n_tup_del,n_tup_hot_upd
  last_vacuum,last_autovacuum,last_analyze,last_autoanalyze
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC LIMIT 20;

             relname              | n_live_tup | n_dead_tup |          last_vacuum          |        last_autovacuum        |         last_analyze          |       last_autoanalyze
----------------------------------+------------+------------+-------------------------------+-------------------------------+-------------------------------+-------------------------------
 sessions                         | 1349078582 |          0 | 2018-01-13 06:04:57.909765+00 | 2019-07-17 14:54:21.371444+00 | 2018-01-13 06:06:06.23267+00  | 2019-04-26 18:30:16.136417+00
 schema_migrations                |        157 |          0 |                               | 2019-07-13 07:21:44.093876+00 |                               |
 users                            |         15 |          2 |                               | 2019-06-27 18:00:28.98646+00  |                               | 2018-12-19 05:26:35.64335+00
```

The [`pg_class`](https://www.postgresql.org/docs/9.3/catalog-pg-class.html) view can also be used but does not directly provide schema details.
It does generally provide a more accurate row count however.

* `reltuples` (float4) - Number of rows in the table. This is only an estimate used by the planner. It is updated by VACUUM, ANALYZE, and a few DDL commands such as CREATE INDEX.

```
SELECT relname,reltuples FROM pg_class WHERE relname in ('sessions','schema_migrations','users');

      relname      |  reltuples
-------------------+-------------
 schema_migrations |         157
 sessions          | 1.34667e+09
 users             |          15
```

### Find all schemas that contain tables with the same name

Query the [`information_schema.tables`](https://www.postgresql.org/docs/9.3/infoschema-tables.html) to find duplicate table names. For example:

```
SELECT table_name, string_agg(table_schema, ', ') as table_schemas
FROM information_schema.tables
WHERE table_name in (select table_name from information_schema.tables where table_schema='myschema')
GROUP BY table_name ORDER BY table_name;

                table_name                 | table_schemas
-------------------------------------------+---------------
 schema_migrations                         | myschema, other_schema
 sessions                                  | myschema
 users                                     | myschema
```
