# #073 Cheat Sheet

Basic administration and data management command cheats...

## Create User and Database

```sh
mysql -u root
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';
CREATE DATABASE mydb;
GRANT ALL ON mydb.* TO 'username'@'localhost';
```

Test it:

```sh
mysql -u username -p mydb
```

## Import and Export

### How To Dump a Database

Doc: [mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html)

```sh
mysqldump -u username -p mydb > dump.sql
```

## Database Information

### Describe

### mysqlshow

See also:

* [mysqlshow](https://dev.mysql.com/doc/refman/8.0/en/mysqlshow.html)

Use mysqlshow to Display Database, Table, and Column Information

```sh
mysqlshow -u username -p
```

### Poking around the information_schema

```sh
SELECT VERSION(), CURRENT_DATE;
SHOW DATABASES;
use information_schema;
SHOW GRANTS;
SHOW FULL TABLES;
desc COLUMNS;
desc TABLES;

-- listing databases
select schema_name as 'database'
  from information_schema.schemata;

-- listing tables in a schema
select table_name,table_rows,table_type,engine
  from information_schema.tables
 where table_schema = 'information_schema';


-- listing tables sizes in a schema
select table_name,table_rows,table_type,engine,
  ROUND((data_length+index_length)/1024/1024,2) as 'total_size_mb',
  ROUND((data_length+index_length-data_free)/1024/1024,2) as 'data_used_mb',
  ROUND(data_free/1024/1024,2) as 'data_free_mb'
  from information_schema.tables
 where table_schema = 'mydb';

-- listing a tables columns
select column_name, column_key, data_type, numeric_precision, numeric_scale, is_nullable, ordinal_position, column_default
  from information_schema.columns
 where table_schema = 'mydb'
   and table_name = 'mytable';

-- listing constraints on a table
select a.table_name, a.constraint_name, b.column_name, a.constraint_type
  from information_schema.table_constraints a,
       information_schema.key_column_usage b
 where a.table_name = 'mytable'
   and a.table_schema = 'mydb'
   and a.table_name = b.table_name
   and a.table_schema = b.table_schema
   and a.constraint_name = b.constraint_name;

select a.table_name, a.constraint_name, b.column_name, a.constraint_type
  from information_schema.table_constraints a
       left join information_schema.key_column_usage b
              on a.table_name = b.table_name
             and a.table_schema = b.table_schema
             and a.constraint_name = b.constraint_name
 where a.table_name = 'mytable'
   and a.table_schema = 'mydb';
```

## Query Analysis

See: [using EXPLAIN](https://dev.mysql.com/doc/refman/8.0/en/using-explain.html)

EXPLAIN works with SELECT, DELETE, INSERT, REPLACE, and UPDATE statements.

e.g. (with output in JSON format);

```sh
EXPLAIN FORMAT = json SELECT .... ;
```

## Indexes

See also:

* [CREATE INDEX](https://dev.mysql.com/doc/refman/8.0/en/create-index.html) - manual
* [How to see indexes for a database or table?](https://stackoverflow.com/questions/5213339/how-to-see-indexes-for-a-database-or-table) - stackoverflow
* [Is there an optimal method for ordering a MYSQL composite index?](https://stackoverflow.com/questions/9537128/is-there-an-optimal-method-for-ordering-a-mysql-composite-index) - stackoverflow

## How to see indexes for a database or table?

For a specific table:

```sh
SHOW INDEX FROM yourtable;
```

To see indexes for all tables within a specific schema you can use the STATISTICS table from INFORMATION_SCHEMA:

```sh
SELECT DISTINCT
    TABLE_NAME,
    INDEX_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'your_schema';
```

SHOW {INDEX | INDEXES | KEYS}
    {FROM | IN} tbl_name
    [{FROM | IN} db_name]

### Create Index

```sh
CREATE INDEX index_name ON table (column1, column2);
```

General guidelines for a multi-column index:

* columns with highest cardinality first
* similar cardinality, put the smaller one first
* selecting with ranges: put last
