--
-- ----------------------------------------------------------------------------------------
-- (1) Afbau Tabelle level 1
-- ----------------------------------------------------------------------------------------
--
-- drop table if exists l1;
select * from entry_level_output;
drop table if exists l1;
create table l1 as
select
 CAST(1 AS INT) as Level ,
 el.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f. source_id ,
 f2f.target_id
from entry_level_output el , public.fieldtofield f2f 
where    el.output_feld_id = f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l1 order by 1 , 3 , 2 , 4 , 5; -- 8
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) from l1
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1;
--
-- ----------------------------------------------------------------------------------------
-- (2) Afbau Tabelle level 2
-- ----------------------------------------------------------------------------------------
--
drop table if exists l2;
create table l2 as
select 
 CAST(2 AS INT) as Level ,
 l1.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f.source_id ,
 f2f.target_id
from l1 , public.fieldtofield f2f
where    l1.source_id = f2f.target_id
--and not (f2f.source_id = f2f.target_id)
--and not (f2f.source_id = l1.target_id)
and not exists (select 0 from entry_level_output el where f2f.source_id = el.output_feld_id)
group by l1.output_feld_id , f2f.flow_id , f2f.input_id , f2f.source_id , f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l2 order by 1 , 3 , 2 , 4 , 5; -- 24
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) 
from l2
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1
order by count(*) desc; 
--
-- ----------------------------------------------------------------------------------------
-- (3) Afbau Tabelle level 3
-- ----------------------------------------------------------------------------------------
--
drop table if exists l3;
create table l3 as
select 
 CAST(3 AS INT) as Level ,
 l2.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f.source_id ,
 f2f.target_id
from l2 , public.fieldtofield f2f
where    l2.source_id = f2f.target_id
--and not (f2f.source_id = f2f.target_id)
--and not (f2f.source_id = l2.target_id)
and not exists (select 0 from entry_level_output el where f2f.source_id = el.output_feld_id)
and not exists (select 0 from l2 where f2f.source_id = l2.target_id)
group by l2.output_feld_id , f2f.flow_id , f2f.input_id , f2f.source_id , f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l3 order by 1 , 3 , 2 , 4 , 5; -- 15
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) 
from l3
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1
order by count(*) desc; 
--
-- ----------------------------------------------------------------------------------------
-- (4) Afbau Tabelle level 4
-- ----------------------------------------------------------------------------------------
--
drop table if exists l4;
create table l4 as
select 
 CAST(4 AS INT) as Level ,
 l3.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f.source_id ,
 f2f.target_id
from l3 , public.fieldtofield f2f
where    l3.source_id = f2f.target_id
--and not (f2f.source_id = f2f.target_id)
--and not (f2f.source_id = l3.target_id)
and not exists (select 0 from entry_level_output el where f2f.source_id = el.output_feld_id)
and not exists (select 0 from l2 where f2f.source_id = l2.target_id)
and not exists (select 0 from l3 where f2f.source_id = l3.target_id)
group by l3.output_feld_id , f2f.flow_id , f2f.input_id , f2f.source_id , f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l4 order by 1 , 3 , 2 , 4 , 5; -- 
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) 
from l4
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1
order by count(*) desc; 
--
-- ----------------------------------------------------------------------------------------
-- (5) Afbau Tabelle level 5
-- ----------------------------------------------------------------------------------------
--
drop table if exists l5;
create table l5 as
select 
 CAST(5 AS INT) as Level ,
 l4.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f.source_id ,
 f2f.target_id
from l4 , public.fieldtofield f2f
where    l4.source_id = f2f.target_id
--and not (f2f.source_id = f2f.target_id)
--and not (f2f.source_id = l4.target_id)
and not exists (select 0 from entry_level_output el where f2f.source_id = el.output_feld_id)
and not exists (select 0 from l2 where f2f.source_id = l2.target_id)
and not exists (select 0 from l3 where f2f.source_id = l3.target_id)
and not exists (select 0 from l4 where f2f.source_id = l4.target_id)
group by l4.output_feld_id , f2f.flow_id , f2f.input_id , f2f.source_id , f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l5 order by 1 , 3 , 2 , 4 , 5; -- 0
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) 
from l5
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1
order by count(*) desc; 
--
-- ----------------------------------------------------------------------------------------
-- (6) Afbau Tabelle level 6
-- ----------------------------------------------------------------------------------------
--
drop table if exists l6;
create table l6 as
select 
 CAST(6 AS INT) as Level ,
 l5.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f.source_id ,
 f2f.target_id
from l5 , public.fieldtofield f2f
where    l5.source_id = f2f.target_id
--and not (f2f.source_id = f2f.target_id)
--and not (f2f.source_id = l5.target_id)
and not exists (select 0 from entry_level_output el where f2f.source_id = el.output_feld_id)
and not exists (select 0 from l2 where f2f.source_id = l2.target_id)
and not exists (select 0 from l3 where f2f.source_id = l3.target_id)
and not exists (select 0 from l4 where f2f.source_id = l4.target_id)
and not exists (select 0 from l5 where f2f.source_id = l5.target_id)
group by l5.output_feld_id , f2f.flow_id , f2f.input_id , f2f.source_id , f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l6 order by 1 , 3 , 2 , 4 , 5; -- 0
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) 
from l6
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1
order by count(*) desc; 
--
-- ----------------------------------------------------------------------------------------
-- (7) Afbau Tabelle level 7
-- ----------------------------------------------------------------------------------------
--
drop table if exists l7;
create table l7 as
select 
 CAST(7 AS INT) as Level ,
 l6.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f.source_id ,
 f2f.target_id
from l6 , public.fieldtofield f2f
where    l6.source_id = f2f.target_id
--and not (f2f.source_id = f2f.target_id)
--and not (f2f.source_id = l6.target_id)
and not exists (select 0 from entry_level_output el where f2f.source_id = el.output_feld_id)
and not exists (select 0 from l2 where f2f.source_id = l2.target_id)
and not exists (select 0 from l3 where f2f.source_id = l3.target_id)
and not exists (select 0 from l4 where f2f.source_id = l4.target_id)
and not exists (select 0 from l5 where f2f.source_id = l5.target_id)
and not exists (select 0 from l6 where f2f.source_id = l6.target_id)
group by l6.output_feld_id , f2f.flow_id , f2f.input_id , f2f.source_id , f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l7 order by 1 , 3 , 2 , 4 , 5; -- 0
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) 
from l7
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1
order by count(*) desc; 
--
-- ----------------------------------------------------------------------------------------
-- (8) Afbau Tabelle level 8
-- ----------------------------------------------------------------------------------------
--
drop table if exists l8;
create table l8 as
select 
 CAST(8 AS INT) as Level ,
 l7.output_feld_id ,
 f2f.flow_id ,
 f2f.input_id ,
 f2f.source_id ,
 f2f.target_id
from l7 , public.fieldtofield f2f
where    l7.source_id = f2f.target_id
--and not (f2f.source_id = f2f.target_id)
--and not (f2f.source_id = l7.target_id)
and not exists (select 0 from entry_level_output el where f2f.source_id = el.output_feld_id)
and not exists (select 0 from l2 where f2f.source_id = l2.target_id)
and not exists (select 0 from l3 where f2f.source_id = l3.target_id)
and not exists (select 0 from l4 where f2f.source_id = l4.target_id)
and not exists (select 0 from l5 where f2f.source_id = l5.target_id)
and not exists (select 0 from l6 where f2f.source_id = l6.target_id)
and not exists (select 0 from l7 where f2f.source_id = l7.target_id)
group by l7.output_feld_id , f2f.flow_id , f2f.input_id , f2f.source_id , f2f.target_id
order by 1 , 3 , 2 , 4 , 5;
select * from l8 order by 1 , 3 , 2 , 4 , 5; -- 0
select  output_feld_id , flow_id , input_id , source_id , target_id ,count(*) 
from l8
group by output_feld_id , flow_id , input_id , source_id , target_id
having count(*) > 1
order by count(*) desc; 
--
-- ----------------------------------------------------------------------------------------
-- (9) Afbau Result Tabele
-- ----------------------------------------------------------------------------------------
--
drop table if exists l_all;
create table l_all as
select * from l1
union
select * from l2
union
select * from l3
union
select * from l4
union
select * from l5
union
select * from l6
union
select * from l7
union
select * from l8
order by 1 , 2 , 4 , 3 , 5 , 6;
select * from l_all
order by 1 , 2 , 4 , 3 , 5 , 6;

select level , count(*) from l_all group by level order by level;

drop table if exists f_fieldtofield_output_result;
create table f_fieldtofield_output_result as
select
 l.level ,
 l.output_feld_id ,
 t.name as output_feld_name,
 pg.name as program_name ,
 l.flow_id ,
 l.input_id ,
 io.name as input_file_name ,
 l.source_id ,
 t1.name as source_feld_name ,
 l.target_id ,
 t2.name as target_feld_name
from
 l_all l ,
 public.type t ,
 public.input_output io ,
 public.type t1 ,
 public.type t2 ,
 public.program_flow pf ,
 public.program pg
where l.output_feld_id = t.id
and l.input_id = io.id
and l.source_id = t1.id
and l.target_id = t2.id
and l.flow_id = pf.flow
and pf.program = pg.id
order by l.level , l.output_feld_id , l.flow_id , l.input_id , l.source_id , l.target_id
;
select * from f_fieldtofield_output_result 
order by level , output_feld_id , flow_id , input_id , source_id , target_id
;
