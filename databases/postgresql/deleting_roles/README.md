# deleting_roles

Notes on methods to inspect PostgreSQL role permissions, revoke permissions and drop roles.

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

Problem: a PostgreSQL role (say "a.user") exists with miscellaneous permissions and needs to be removed.

Challenge: the basic `DROP ROLE "a.user";` syntax does not have a cascade option - all permissions for the role
need to be cleaned up before the role can be removed. PostgreSQL provides some hints but not precise details
of what needs to be fixed:

```
# DROP ROLE "a.user";
ERROR:  role "a.user" cannot be dropped because some objects depend on it
DETAIL:  privileges for table lcktest.t1
privileges for schema lcktest
privileges for database lcktest_db
```

### Creating a Sample Database and Role

```
$ psql
# CREATE DATABASE lcktest_db;
# \c lcktest_db
You are now connected to database "lcktest_db" as user "postgres".
lcktest_db=# CREATE SCHEMA lcktest;
lcktest_db=# CREATE TABLE lcktest.t1 (id integer NOT NULL, name varchar(20));
lcktest_db=# CREATE ROLE "a.user" LOGIN PASSWORD 'password' INHERIT;
```

Assigning some role permissions:

```
lcktest_db=# GRANT CONNECT ON DATABASE lcktest_db to "a.user";
lcktest_db=# GRANT USAGE ON SCHEMA lcktest TO "a.user";
lcktest_db=# GRANT SELECT ON lcktest.t1 TO "a.user";
```

### Listing Roles and Permissions

Listing roles:
```
SELECT rolname,rolconnlimit,rolconfig FROM pg_roles ORDER BY rolname;
      rolname      | rolconnlimit | rolconfig
-------------------+--------------+-----------
 a.user            |           -1 |
 (etc)
```

Listing table permissions:

```
SELECT table_catalog, table_schema, table_name, privilege_type
FROM   information_schema.table_privileges
WHERE  grantee = 'a.user';
 table_catalog | table_schema | table_name | privilege_type
---------------+--------------+------------+----------------
 lcktest_db    | lcktest      | t1         | SELECT
(1 row)
```

Using
[psql meta commands](https://www.postgresql.org/docs/current/app-psql.html) e.g.

* `\dp` Lists tables, views and sequences with their associated access privileges
* `\l+`  List the databases in the server and show access privileges.

```
lcktest_db=# \dp lcktest.t1
                                Access privileges
 Schema  | Name | Type  |    Access privileges    | Column privileges | Policies
---------+------+-------+-------------------------+-------------------+----------
 lcktest | t1   | table | "a.user"=r/postgres     |                   |
(1 row)


lcktest_db=# \l+ lcktest_db
                                              List of databases
    Name    |  Owner  | Encoding | Collate | Ctype |  Access privileges  |  Size   | Tablespace | Description
------------+---------+----------+---------+-------+---------------------+---------+------------+-------------
 lcktest_db | babylon | UTF8     | C       | UTF-8 | "a.user"=c/postgres | 7151 kB | pg_default |
(1 row)
```

### Revoking Permissions

```
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA lcktest FROM "a.user";
REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA lcktest FROM "a.user";
REVOKE ALL PRIVILEGES ON SCHEMA lcktest FROM "a.user";
REVOKE ALL PRIVILEGES ON DATABASE lcktest_db FROM "a.user";
```

So can finally drop the role:

```
lcktest_db=# DROP ROLE "a.user";
DROP ROLE
```

## Cleaning Up

```
# \c postgres
You are now connected to database "postgres" as user "postgres".
postgres=# DROP DATABASE lcktest_db;
DROP DATABASE
```

## Credits and References

* [REVOKE docs](https://www.postgresql.org/docs/9.0/sql-revoke.html)
* [psql meta commands](https://www.postgresql.org/docs/current/app-psql.html)
