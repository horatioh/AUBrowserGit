--
-- ----------------------------------------------------------------------------------------
-- (1)
-- ----------------------------------------------------------------------------------------
--
-- insert into f_output_datei values (4596);
-- insert into f_output_datei values (5278);
--
drop table if exists f_output_felder;
create table f_output_felder
(id int);
--
insert into f_output_felder select f_id from f_type, f_output_datei where f_type.d_id  = f_output_datei.id;
insert into f_output_felder select f_id from f_type, f_output_record where f_type.r_id = f_output_record.id;
insert into f_output_felder select f_id from f_type, f_output_feld where f_type.f_id   = f_output_feld.id;
--
-- ----------------------------------------------------------------------------------------
-- (2) Afbau Tabelle entry_level
-- ----------------------------------------------------------------------------------------
--
DROP TABLE entry_level_output;
CREATE TABLE entry_level_output AS
SELECT
  if.id AS "output_feld_id" ,
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
RIGHT OUTER JOIN f_output_felder IF
ON ft."f_id" = if.id
ORDER BY 4 ,  11 ,  17;
-- SELECT * FROM entry_level_output;
-- SELECT COUNT(*) FROM entry_level_output; -- 94
-- SELECT COUNT(*) from f_output_felder;
-- select * from entry_level_output order by output_feld_id , d_id , d_recordid , f_id;
