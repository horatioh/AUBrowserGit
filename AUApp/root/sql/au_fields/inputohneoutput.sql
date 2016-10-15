--
-- ----------------------------------------------------------------------------------------
-- (1) Ergebnisstabelle: f_input_ohne_output
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_input_ohne_output;
--
create table f_input_ohne_output as
select 
 el.* ,
 f2f.flow_id   as l1_flow_id ,
 f2f.input_id  as l1_input_id ,
 f2f.source_id as l1_source_id ,
 f2f.target_id as l1_target_id
 from
 entry_level el left outer join public.fieldtofield f2f on el.f_id = f2f.source_id
where f2f.flow_id is null
 order by 2;
--
select * from f_input_ohne_output;
