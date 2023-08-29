\echo >>> set some connection options

-- turn off output pagination
\pset pager

\echo >>> create a test database

CREATE DATABASE lck ENCODING='UTF8';

\c lck;

\echo >>> explicit sequences

CREATE TABLE t1 (
  id integer NOT NULL,
  name varchar(20)
);

CREATE SEQUENCE t1_custom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE t1 ALTER COLUMN id SET DEFAULT nextval('t1_custom_id_seq'::regclass);

ALTER SEQUENCE t1_custom_id_seq OWNED BY t1.id;

\d t1

select pg_get_serial_sequence('t1', 'id');


insert into t1(name) values
('t1.1.1'),
('t1.1.2'),
('t1.1.3');

select * from t1;


-- this should be correct

delete from t1 where id=3;

SELECT setval(pg_get_serial_sequence('t1', 'id'), max(id)) FROM t1;

insert into t1(name) values('t1.2.3');

select * from t1;

-- this should also be correct

delete from t1 where id=3;

SELECT setval(pg_get_serial_sequence('t1', 'id'), (SELECT MAX(id) FROM t1));

insert into t1(name) values('t1.3.3');

select * from t1;

-- with empty table - fails to reset

truncate t1;

SELECT setval(pg_get_serial_sequence('t1', 'id'), max(id)) FROM t1;

insert into t1(name) values('t1.4.1');

select * from t1;


-- with empty table

truncate t1;

ALTER SEQUENCE t1_custom_id_seq RESTART WITH 1;

insert into t1(name) values('t1.5.1');

select * from t1;

-- with empty table - resets correctly

truncate t1;

SELECT setval(pg_get_serial_sequence('t1', 'id'), coalesce(max(id),0) + 1, false) FROM t1;

insert into t1(name) values
('t1.6.1'),
('t1.6.2'),
('t1.6.3');

select * from t1;

-- this should be correct

delete from t1 where id=3;

SELECT setval(pg_get_serial_sequence('t1', 'id'), coalesce(max(id),0) + 1, false) FROM t1;

insert into t1(name) values('t1.7.3');

select * from t1;


\echo >>> serial columns

CREATE TABLE t2 (
  id serial NOT NULL,
  name varchar(20)
);

\d t2

select pg_get_serial_sequence('t2', 'id');

insert into t2(name) values
('t2.1.1'),
('t2.1.2'),
('t2.1.3');

select * from t2;

delete from t2 where id=3;

SELECT setval(pg_get_serial_sequence('t2', 'id'), coalesce(max(id),0) + 1, false) FROM t1;

insert into t2(name) values('t2.2.3');

select * from t2;

\echo >>> cleanup - drop everything we just created

DROP TABLE t1;
DROP TABLE t2;

\c postgres;

DROP DATABASE lck;
