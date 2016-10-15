--
-- ----------------------------------------------------------------------------------------
-- (1) Ergebnisstabelle: f_output_ohne_intput
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_output_ohne_intput;
--
create table f_output_ohne_intput as
select 
 el.* ,
 f2f.flow_id   as l1_flow_id ,
 f2f.input_id  as l1_input_id ,
 f2f.source_id as l1_source_id ,
 f2f.target_id as l1_target_id
 from
 entry_level_output el left outer join public.fieldtofield f2f on el.f_id = f2f.target_id
where f2f.flow_id is null
 order by 2;
--
select * from f_output_ohne_intput;
