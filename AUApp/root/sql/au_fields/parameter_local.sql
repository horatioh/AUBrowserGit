-- ----------------------------------------------------------------------------------------
-- (1) aufbau parametertabelle
-- ----------------------------------------------------------------------------------------
--
drop table f_parameter;
--
create table f_parameter
(id  bigint);
--
-- hier bitte die id des "input_output" objektes eintragen. 5577 ist die id des objektes "vm1005fm" bei mir in meine repository.
-- 
insert into f_parameter values(5764);

-- check: select * from f_parameter;

