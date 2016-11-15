--
-- ----------------------------------------------------------------------------------------
-- (1)
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_input_felder;
create table f_input_felder
(id int);
--
insert into f_input_felder select f_id from f_type, f_input_datei where f_type.d_id = f_input_datei.id;
insert into f_input_felder select f_id from f_type, f_input_record where f_type.r_id = f_input_record.id;
insert into f_input_felder select f_id from f_type, f_input_feld where f_type.f_id = f_input_feld.id;
--
-- ----------------------------------------------------------------------------------------
-- (2) Afbau Tabelle entry_level
-- ----------------------------------------------------------------------------------------
--
DROP TABLE entry_level;
CREATE TABLE entry_level AS
SELECT
  if.id AS "input_feld_id" ,
  --
  ft."d_id" ,
  ft."d_name" ,
  ft."d_type" ,
  ft."d_recordid" ,
  ft."d_parent" ,
  ft."d_succession" ,
  ft."d_precision",
  --
  ft."r_id" ,
  ft."r_name" ,
  ft."r_type" ,
  ft."r_parent" ,
  ft."r_succession",
  ft."r_precision" ,
  --
  ft."f_id" ,
  ft."f_name" ,
  ft."f_type",
  ft."f_parent",
  ft."f_succession",
  ft."f_precision" ,
  --
  ft."io_uri"
FROM f_type ft
RIGHT OUTER JOIN f_input_felder IF
ON ft."f_id" = if.id
ORDER BY 4 ,  11 ,  17;
SELECT * FROM entry_level;
SELECT COUNT(*) FROM entry_level; -- 94
SELECT COUNT(*) from f_input_felder; -- 94
select * from entry_level order by input_feld_id , input_feld_id , d_recordid , f_id;
