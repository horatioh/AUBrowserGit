-- ----------------------------------------------------------------------------------------
-- (1) Aufbau Parametertabelle f_input_datei , f_output_datei
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_input_datei;
drop table if exists f_output_datei;
--
create table f_input_datei
(id  bigint);
create table f_output_datei
(id  bigint);
--
-- Hier bitte die ID des "input_output" objektes eintragen.
-- 
insert into f_input_datei values(5764);
insert into f_output_datei values(5764);

-- check: select * from f_input_datei;
-- check: select * from f_output_datei;

-- ----------------------------------------------------------------------------------------
-- (2) Aufbau Parametertabelle f_input_record , f_input_record
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_input_record;
drop table if exists f_output_record;
--
create table f_input_record
(id  bigint);
create table f_output_record
(id  bigint);
--
-- Hier bitte die ID des "records" für das input_output Objekt eintragen.
-- 
--insert into f_input_record values(5577);
--insert into f_output_record values(5577);

-- check: select * from f_input_record;
-- check: select * from f_output_record;

-- ----------------------------------------------------------------------------------------
-- (3) Aufbau Parametertabelle f_input_feld , f_output_feld
-- ----------------------------------------------------------------------------------------

drop table if exists f_input_feld;
drop table if exists f_output_feld;
--
create table f_input_feld
(id  bigint);
create table f_output_feld
(id  bigint);
--
-- Hier bitte die ID des "feldes" für das input_output Objekt eintragen.
-- 
--insert into f_input_feld values(5577);
--insert into f_output_feld values(5577);

-- check: select * from f_input_feld;
-- check: select * from f_output_feld;
--
-- ----------------------------------------------------------------------------------------
-- (4) Aufbau Tabelle exclude_pgm
-- ----------------------------------------------------------------------------------------
drop table if exists exclude_pgm;
create table exclude_pgm(id integer);
--
