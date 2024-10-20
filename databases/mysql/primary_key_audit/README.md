# #254 Key Audit

How to list primary key details in a MySQL database

## Notes

Need to check that all primary keys are appropriately defined in a MySQL database?
Querying the information schema (
[tables](https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.6/en/information-schema-tables-table.html),
[columns](https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.6/en/information-schema-columns-table.html), and
[statistics](https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.6/en/information-schema-statistics-table.html)
) makes it possible to get a

The following example filters for select tables and shows the primary key definition including data type:

```bash
$ mysql -uroot
mysql>
    select
        tab.table_schema,
        tab.table_name,
        sta.index_name as pk_name,
        sta.seq_in_index as column_id,
        sta.column_name,
        col.data_type
    from information_schema.tables as tab
    inner join information_schema.statistics as sta
            on sta.table_schema = tab.table_schema
            and sta.table_name = tab.table_name
            and sta.index_name = 'primary'
    inner join information_schema.columns as col
            on col.table_schema = tab.table_schema
            and col.table_name = tab.table_name
            and col.column_name = sta.column_name
    where tab.table_type = 'BASE TABLE'
        and tab.table_schema = 'mysql' -- optionally filter by schema
        and tab.table_name like 'time%' -- optionally filter by table name
    order by tab.table_name,
        column_id;
+--------------+---------------------------+---------+-----------+--------------------+-----------+
| TABLE_SCHEMA | TABLE_NAME                | pk_name | column_id | COLUMN_NAME        | DATA_TYPE |
+--------------+---------------------------+---------+-----------+--------------------+-----------+
| mysql        | time_zone                 | PRIMARY |         1 | Time_zone_id       | int       |
| mysql        | time_zone_leap_second     | PRIMARY |         1 | Transition_time    | bigint    |
| mysql        | time_zone_name            | PRIMARY |         1 | Name               | char      |
| mysql        | time_zone_transition      | PRIMARY |         1 | Time_zone_id       | int       |
| mysql        | time_zone_transition      | PRIMARY |         2 | Transition_time    | bigint    |
| mysql        | time_zone_transition_type | PRIMARY |         1 | Time_zone_id       | int       |
| mysql        | time_zone_transition_type | PRIMARY |         2 | Transition_type_id | int       |
+--------------+---------------------------+---------+-----------+--------------------+-----------+
7 rows in set (0.01 sec)
```

## Credits and References

* [List all primary keys (PKs) in MySQL database](https://dataedo.com/kb/query/mysql/list-all-primary-keys-in-database)
* [The INFORMATION_SCHEMA TABLES Table](https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.6/en/information-schema-tables-table.html)
* [The INFORMATION_SCHEMA COLUMNS Table](https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.6/en/information-schema-columns-table.html)
* [The INFORMATION_SCHEMA STATISTICS Table](https://dev.mysql.com/doc/mysql-infoschema-excerpt/5.6/en/information-schema-statistics-table.html)
