
-- ----------------------------------------------------------------------------------------
-- (1) Nicht benutzten Dateien
-- ----------------------------------------------------------------------------------------

drop table if exists not_used_input_output;
create table not_used_input_output as
select * from public.input_output 
where id not in (select input from public.program_input)
and   id not in (select output from public.program_output);

-- ----------------------------------------------------------------------------------------
-- (2) Nur Inputs ("ECHTE INPUTS")
-- ----------------------------------------------------------------------------------------

drop table if exists only_inputs;
create table only_inputs as select * from public.input_output  
where id in (select input from public.program_input)
and   id not in (select output from public.program_output);

-- ----------------------------------------------------------------------------------------
-- (3) Nur Outputs ("ECHTE OUTPUTS")
-- ----------------------------------------------------------------------------------------

drop table if exists only_outputs;
create table only_outputs as select * from public.input_output  
where id not in (select input from public.program_input)
and   id in (select output from public.program_output);

-- ----------------------------------------------------------------------------------------
-- (4) Inputs und Outputs
-- ----------------------------------------------------------------------------------------

drop table if exists inputs_and_outputs;
create table inputs_and_outputs as select * from public.input_output  
where id in (select input from public.program_input)
and   id in (select output from public.program_output);

-- ----------------------------------------------------------------------------------------
-- (5) Check
-- ----------------------------------------------------------------------------------------

-- check: select count(*) from input_output;
--  5.231
-- check: select count(*) from not_used_input_output;
--  1.391
-- check: select count(*) from only_inputs;
--    622
-- check: select count(*) from only_outputs;
--    367
-- check: select count(*) from inputs_and_outputs;
--  2.851


