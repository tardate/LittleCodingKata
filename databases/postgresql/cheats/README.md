# #072 Cheat Sheet

Basic administration and data management command tips and tricks...

## Notes

## psql

The [psql](https://www.postgresql.org/docs/current/app-psql.html) utility is a terminal-based front-end to PostgreSQL.

Running 1-shot commands in the console:

```
$ psql postgres -c "select now();"
              now
-------------------------------
 2019-08-09 10:39:12.805927+08
(1 row)
```

## Testing Database Connectivity

```
$ psql postgres -c "\c"
You are now connected to database "postgres" as user "myname"
```

## Creating a Database

Use [CREATE DATABASE](https://www.postgresql.org/docs/current/sql-createdatabase.html) e.g.

```
CREATE DATABASE mydb ENCODING='UTF8';"
```

And of course, to remove it:

```
DROP DATABASE mydb;
```

### Listing Databases

Use the `\l` command in psql, or to query the schema directly for example:

```
SELECT
  d.datname as database,
  pg_catalog.pg_get_userbyid(d.datdba) as owner,
  d.datcollate,
  d.datctype
FROM pg_database d
WHERE d.datistemplate = false
ORDER BY 1;

           database            |     owner     | datcollate  |  datctype
-------------------------------+---------------+-------------+-------------
 cancannible_demo6_development | paulgallagher | en_US.UTF-8 | en_US.UTF-8
 cancannible_demo6_test        | paulgallagher | en_US.UTF-8 | en_US.UTF-8
 minime_development            | paulgallagher | en_US.UTF-8 | en_US.UTF-8
 postgres                      | paulgallagher | en_US.UTF-8 | en_US.UTF-8
...

```

## Managing Roles

### Creating a Role

Use [CREATE ROLE](https://www.postgresql.org/docs/current/sql-createrole.html) e.g.

```
CREATE ROLE manager LOGIN PASSWORD 'password' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE;
```

Optionally [GRANT](https://www.postgresql.org/docs/current/sql-grant.html) individual permissions:

```
CREATE ROLE reader LOGIN PASSWORD 'password' INHERIT;
grant CONNECT ON DATABASE mydb TO reader;
GRANT USAGE ON SCHEMA myschema TO reader;
GRANT SELECT ON myschema.table1 TO reader;
```

### Connection limit per user

Use the [pg_roles](https://www.postgresql.org/docs/9.3/view-pg-roles.html) view.

```
SELECT rolname, rolconnlimit
FROM pg_roles
WHERE rolconnlimit <> -1;
```

## Analyzing the Schema

### List Tables and Views

Use the `\d` command in psql.

Alternatively, query `information_schema.tables`:

```
select table_catalog,table_schema,table_name,table_type from information_schema.tables;
 table_catalog |    table_schema    |              table_name               | table_type
---------------+--------------------+---------------------------------------+------------
 postgres      | pg_catalog         | pg_statistic                          | BASE TABLE
 postgres      | pg_catalog         | pg_type                               | BASE TABLE
 postgres      | pg_catalog         | pg_policy                             | BASE TABLE
 postgres      | pg_catalog         | pg_authid                             | BASE TABLE
 postgres      | pg_catalog         | pg_shadow                             | VIEW
 postgres      | pg_catalog         | pg_settings                           | VIEW
```

To also get ownership details, use `pg_tables` and `pg_views`:

```
select schemaname as table_schema,tablename as table_name,tableowner as owner, 'BASE TABLE' as table_type from pg_catalog.pg_tables;
select schemaname as table_schema,viewname as table_name,viewowner as owner, 'VIEW' as table_type from pg_catalog.pg_views
```

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
