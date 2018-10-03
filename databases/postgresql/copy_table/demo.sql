\echo >>> set some connection options
-- turn off output pagination
\pset pager

\echo >>> create a test database
CREATE DATABASE lck ENCODING='UTF8';
\c lck;

\echo >>> create test table and data
CREATE TABLE source_table (
  id serial primary key,
  rank integer,
  name varchar(60),
  speed_kmh numeric default 0,
  description varchar(500)
);

INSERT INTO source_table(rank, name, speed_kmh, description) VALUES
(1, 'Peregrine falcon', 389, 'Flight-diving The peregrine falcon is the fastest aerial animal, fastest animal in flight, fastest bird, and the overall fastest member of the animal kingdom. The peregrine achieves its highest velocity not in horizontal level flight, but during its characteristic hunting stoop. While stooping, the peregrine falcon soars to a great height, then dives steeply at speeds of over 200 mph (320 km/h).'),
(2, 'Golden eagle', 320, 'Flight-diving'),
(3, 'White-throated needletail swift', 169, 'Flight'),
(4, 'Eurasian hobby', 160, 'Flight  Can sometimes outfly the swift'),
(5, 'Mexican free-tailed bat', 160, 'Flight  It has been claimed to have the fastest horizontal speed (as opposed to stoop diving speed) of any animal.'),
(6, 'Frigatebird',  153, 'Flight  The frigatebird''s high speed is helped by its having the largest wing-area-to-body-weight ratio of any bird.'),
(7, 'Rock dove (pigeon)', 148.9, 'Flight: Pigeons have been clocked flying 92.5 mph (148.9 km/h) average speed on a 400-mile (640 km) race.'),
(8, 'Spur-winged goose',  142, 'Flight'),
(9, 'Black marlin',   129, 'Swimming: A hooked black marlin has been recorded stripping line off a fishing reel at 120 feet per second (82 mph; 132 km/h).'),
(10, 'Gyrfalcon',  128, 'Flight'),
(11, 'Grey-headed albatross',  127, 'Flight'),
(12, 'Cheetah',  120.7, 'Land  Fastest land-animal, fastest feline, the cheetah can accelerate from 0 to 96.6 km/h (60.0 mph) in under three seconds, though endurance is limited.'),
(13, 'Sailfish',   109.19, 'Flight-swimming'),
(14, 'Anna''s hummingbird',   98.27, 'Flight'),
(15, 'Swordfish',  97, 'Swimming'),
(16, 'Pronghorn',  88.5, 'Land'),
(17, 'Springbok',  88, 'Land'),
(18, 'Blue wildebeest',  80.5, 'Land  '),
(19, 'Lion',   80.5, 'Land'),
(20, 'Blackbuck', 80, 'Land');

\echo >>>>> the structure and data in the test table:
\d source_table
select * from source_table;


\echo >>> using create as with no data:
CREATE TABLE copied_structure AS SELECT * FROM source_table WITH NO DATA;
\echo >>>>> created structure and content:
\d copied_structure
select count(*) from copied_structure;


\echo >>> using create as with no data:
CREATE TABLE copied_data AS SELECT * FROM source_table limit 3;
\echo >>>>> created structure and content:
\d copied_data
select count(*) from copied_data;

\echo >>> using create like:
CREATE TABLE like_structure ( LIKE source_table INCLUDING ALL );
\echo >>>>> created structure and content:
\d like_structure
select count(*) from like_structure;


\echo >>> demonstrate a table switch and patch:
CREATE TABLE new_source_table ( LIKE source_table INCLUDING ALL );
\echo >>>>> add a new index to new_source_table:
CREATE INDEX new_source_table_index ON new_source_table(rank, name);
\echo >>>>> copy over the data:
INSERT INTO new_source_table SELECT * FROM source_table;
\echo >>>>> maybe a good idea to vacuum analyze:
vacuum analyze new_source_table;
\echo >>>>> drop the old table and switch names:
ALTER SEQUENCE source_table_id_seq OWNED BY public.new_source_table.id;
drop table source_table;
ALTER TABLE new_source_table RENAME TO source_table;
\echo >>>>> new source table structure and data:
\d source_table
\d source_table_id_seq
select count(*) from source_table;



\echo >>> cleanup - drop everything we just created

DROP TABLE copied_structure;
DROP TABLE copied_data;
DROP TABLE like_structure;
DROP TABLE source_table;

\c postgres;

DROP DATABASE lck;
