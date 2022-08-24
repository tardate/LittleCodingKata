# PostgreSQL Locks

Notes on managing PostgreSQL locks

## Notes

### Lock Conflicts

The following table summarises the locks that will prevent other locks from being granted,
with examples of the types of commands that will request such locks.

| Lock Requested \ Held       | AS | RS | RE | SUE| S | SRE| E | AE | Example SQL Commands |
|-----------------------------|----|----|----|----|---|----|---|----|-----|
| AS: Access Share            |    |    |    |    |   |    |   | x  | SELECT |
| RS: Row Share               |    |    |    |    |   |    | x | x  | SELECT FOR UPDATE/SHARE |
| RS: Row Exclusive           |    |    |    |    |   | x  | x | x  | INSERT, UPDATE, DELETE |
| SUE: Share Update Exclusive |    |    |    |    | x | x  | x | x  | VACUUM, ALTER TABLE*, СREATE INDEX CONCURRENTLY |
| S: Share                    |    |    |    | x  | x | x  | x | x  | CREATE INDEX |
| SRE: Share Row Exclusive    |    |    | x  | x  | x | x  | x | x  | CREATE TRIGGER, ALTER TABLE |
| E: Exclusive                |    | x  | x  | x  | x | x  | x | x  | REFRESH MAT. VIEW CONCURRENTLY |
| AE: Access Exclusive        | x  | x  | x  | x  | x | x  | x | x  | DROP, TRUNCATE, VACUUM FULL, LOCK TABLE, ALTER TABLE |

### Query Current Locks

Using the
[pg_locks](https://www.postgresql.org/docs/current/view-pg-locks.html)
mixed with some other views to find which users and queries are holding a lock:

    select
      l.pid,
      r.relname,
      locktype,
      l.granted,
      virtualtransaction,
      mode,
      a.usename,
      substr(query,1,50) as current_query
    from pg_locks l
    join pg_stat_activity a on a.pid=l.pid
    join pg_class r on r.oid=l.relation
    where l.pid <> pg_backend_pid()
    order by virtualtransaction,l.pid;

## Credits and References

* [Lock Monitoring](https://wiki.postgresql.org/wiki/Lock_Monitoring) - postgresql wiki
* [pg_locks](https://www.postgresql.org/docs/current/view-pg-locks.html)
* [Locks in PostgreSQL: 1. Relation-level locks](https://postgrespro.com/blog/pgsql/5967999)
