--
-- ----------------------------------------------------------------------------------------
-- (1)
-- ----------------------------------------------------------------------------------------

create index fieldtofield_i1 on public.fieldtofield(flow_id);
create index fieldtofield_i2 on public.fieldtofield(input_id);

drop table field_parameter;
create table field_parameter
(source_id integer);
--
insert into field_parameter values (170428);
--update field_parameter set source_id = 245512;
--
drop table f_fieldtofield;

create table f_fieldtofield as
select
 pf.program    as "pgid"      ,
 pg.name       as "pgname"    ,
 ftf.flow_id   as "flowid"    ,
 ftf.input_id  as "inputid"   ,
 ftf.source_id as "sourceid"  ,
 t1.name       as "inputname" ,
 ftf.target_id as "targetid"  ,
 t2.name       as "outputname" 
from 
 public.fieldtofield ftf ,
 public.type t1 ,
 public.type t2 ,
 public.program_flow pf ,
 public.program pg 
where exists (select 0 from f_type where f_type."d_id" = ftf.input_id)
and t1.id   = ftf.source_id
and t2.id   = ftf.target_id
and pf.flow = ftf.flow_id
and pf.program = pg.id
order by ftf.flow_id, ftf.source_id, ftf.target_id; 

-- check: select * from f_fieldtofield;

drop table f_fieldtofield_l2;
drop table f_fieldtofield_l2z;
--
create table f_fieldtofield_l2z as
select 
 f_ftf."pgid"        as "l1_pgid"       ,
 f_ftf."pgname"      as "l1_pgname"     ,
 f_ftf."flowid"      as "l1_flowid"     ,
 f_ftf."inputid"     as "l1_inputid"    ,
 f_ftf."sourceid"    as "l1_sourceid"   ,
 f_ftf."inputname"   as "l1_inputname"  ,
 f_ftf."targetid"    as "l1_targetid"   ,
 f_ftf."outputname"  as "l1_outputname" , 
 ftf.flow_id         as "l2_flowid"     , 
 ftf.input_id        as "l2_inputid"    ,
 ftf.source_id       as "l2_sourceid"   ,
 ftf.target_id       as "l2_targetid"
from
 f_fieldtofield f_ftf left outer join public.fieldtofield ftf
                      on   (f_ftf."targetid" = ftf.source_id
                            and not (f_ftf."flowid"  = ftf.flow_id
                            and      f_ftf."inputid" = ftf.input_id)
                           )
where f_ftf."sourceid" in (select source_id from field_parameter)
order by 2 , 1 , 3 , 8 , 7 , 9;

create table f_fieldtofield_l2 as
select 
 f_ftf_l2z."l1_pgid"        as "l1_pgid"       ,
 f_ftf_l2z."l1_pgname"      as "l1_pgname"     ,
 f_ftf_l2z."l1_flowid"      as "l1_flowid"     ,
 f_ftf_l2z."l1_inputid"     as "l1_inputid"    ,
 f_ftf_l2z."l1_sourceid"    as "l1_sourceid"   ,
 f_ftf_l2z."l1_inputname"   as "l1_inputname"  ,
 f_ftf_l2z."l1_targetid"    as "l1_targetid"   ,
 f_ftf_l2z."l1_outputname"  as "l1_outputname" , 
 pg.id                      as "l2_pgid"       ,
 pg.name                    as "l2_pgname"     ,
 f_ftf_l2z."l2_flowid"      as "l2_flowid"     , 
 f_ftf_l2z."l2_inputid"     as "l2_inputid"    ,
 f_ftf_l2z."l2_sourceid"    as "l2_sourceid"   ,
 t1.name                    as "l2_inputname"  ,
 f_ftf_l2z."l2_targetid"    as "l2_targetid"   ,
 t2.name                    as "l2_outputname"  
from
 f_fieldtofield_l2z f_ftf_l2z left outer join public.type t1 on (f_ftf_l2z."l2_sourceid" = t1.id)
                              left outer join public.type t2 on (f_ftf_l2z."l2_targetid" = t2.id) ,
 public.program_flow pf ,
 public.program pg
where f_ftf_l2z."l2_flowid" = pf.flow 
and   pf.program            = pg.id
order by 2 , 1 , 3 , 8 , 7 , 9;
--

select count (*) from f_fieldtofield_l2;

drop table f_fieldtofield_l3z;
drop table f_fieldtofield_l3;

create table f_fieldtofield_l3z as
select 
 f_ftf_l2."l1_pgid"         as "l1_pgid"       ,
 f_ftf_l2."l1_pgname"       as "l1_pgname"     ,
 f_ftf_l2."l1_flowid"       as "l1_flowid"     ,         
 f_ftf_l2."l1_inputid"      as "l1_inputid"    ,
 f_ftf_l2."l1_sourceid"     as "l1_sourceid"   ,
 f_ftf_l2."l1_inputname"    as "l1_inputname"  ,
 f_ftf_l2."l1_targetid"     as "l1_targetid"   ,
 f_ftf_l2."l1_outputname"   as "l1_outputname" ,
 f_ftf_l2."l2_pgid"         as "l2_pgid"       ,
 f_ftf_l2."l2_pgname"       as "l2_pgname"     ,
 f_ftf_l2."l2_flowid"       as "l2_flowid"     ,
 f_ftf_l2."l2_inputid"      as "l2_inputid"    ,
 f_ftf_l2."l2_sourceid"     as "l2_sourceid"   ,
 f_ftf_l2."l2_inputname"    as "l2_inputname"  ,
 f_ftf_l2."l2_targetid"     as "l2_targetid"   ,
 f_ftf_l2."l2_outputname"   as "l2_outputname" ,
 ftf.flow_id                as "l3_flowid"     , 
 ftf.input_id               as "l3_inputid"    ,
 ftf.source_id              as "l3_sourceid"   ,
 ftf.target_id              as "l3_targetid"
from
 f_fieldtofield_l2 f_ftf_l2 left outer join public.fieldtofield ftf
                      on   (f_ftf_l2."l2_targetid" = ftf.source_id
                            and not ((f_ftf_l2."l1_flowid"  = ftf.flow_id and f_ftf_l2."l1_inputid" = ftf.input_id)
                            or       (f_ftf_l2."l2_flowid"  = ftf.flow_id and f_ftf_l2."l2_inputid" = ftf.input_id))
                           )
order by 2 , 1 , 3 , 8 , 7 , 9 , 14 , 13 , 15;

create table f_fieldtofield_l3 as
select 
 f_ftf_l3z."l1_pgid"        as "l1_pgid"       ,
 f_ftf_l3z."l1_pgname"      as "l1_pgname"     ,
 f_ftf_l3z."l1_flowid"      as "l1_flowid"     ,         
 f_ftf_l3z."l1_inputid"     as "l1_inputid"    ,
 f_ftf_l3z."l1_sourceid"    as "l1_sourceid"   ,
 f_ftf_l3z."l1_inputname"   as "l1_inputname"  ,
 f_ftf_l3z."l1_targetid"    as "l1_targetid"   ,
 f_ftf_l3z."l1_outputname"  as "l1_outputname" ,
 f_ftf_l3z."l2_pgid"         as "l2_pgid"       ,
 f_ftf_l3z."l2_pgname"       as "l2_pgname"     ,
 f_ftf_l3z."l2_flowid"      as "l2_flowid"     ,
 f_ftf_l3z."l2_inputid"     as "l2_inputid"    ,
 f_ftf_l3z."l2_sourceid"    as "l2_sourceid"   ,
 f_ftf_l3z."l2_inputname"   as "l2_inputname"  ,
 f_ftf_l3z."l2_targetid"    as "l2_targetid"   ,
 f_ftf_l3z."l2_outputname"  as "l2_outputname" ,
 pg.id                      as "l3_pgid"       ,
 pg.name                    as "l3_pgname"     ,
 f_ftf_l3z."l3_flowid"      as "l3_flowid"     , 
 f_ftf_l3z."l3_inputid"     as "l3_inputid"    ,
 f_ftf_l3z."l3_sourceid"    as "l3_sourceid"   ,
 t1.name                    as "l3_inputname"  ,
 f_ftf_l3z."l3_targetid"    as "l3_targetid"   ,
 t2.name                    as "l3_outputname"  
from
 f_fieldtofield_l3z f_ftf_l3z left outer join public.type t1 on (f_ftf_l3z."l3_sourceid" = t1.id)
                              left outer join public.type t2 on (f_ftf_l3z."l3_targetid" = t2.id) ,
 public.program_flow pf ,
 public.program pg
where f_ftf_l3z."l3_flowid" = pf.flow 
and   pf.program            = pg.id
order by 2 , 1 , 3 , 8 , 7 , 9 , 14 , 13 , 15;
--

-- check: select count(*) from f_fieldtofield_l3;

-- select
--  f_ftf_l3."l1_pgid"        as "l1_pgid"       ,
--  f_ftf_l3."l1_pgname"      as "l1_pgname"     ,
--  f_ftf_l3."l1_flowid"      as "l1_flowid"     ,         
--  f_ftf_l3."l1_inputid"     as "l1_inputid"    ,
--  f_ftf_l3."l1_sourceid"    as "l1_sourceid"   ,
--  f_ftf_l3."l1_inputname"   as "l1_inputname"  ,
--  f_ftf_l3."l1_targetid"    as "l1_targetid"   ,
--  f_ftf_l3."l1_outputname"  as "l1_outputname" ,
--  f_ftf_l3."l2_pgid"        as "l2_pgid"       ,
--  f_ftf_l3."l2_pgname"      as "l2_pgname"     ,
--  f_ftf_l3."l2_flowid"      as "l2_flowid"     ,
--  f_ftf_l3."l2_inputid"     as "l2_inputid"    ,
--  f_ftf_l3."l2_sourceid"    as "l2_sourceid"   ,
--  f_ftf_l3."l2_inputname"   as "l2_inputname"  ,
--  f_ftf_l3."l2_targetid"    as "l2_targetid"   ,
--  f_ftf_l3."l2_outputname"  as "l2_outputname" ,
--  f_ftf_l3."l3_pgid"        as "l3_pgid"       ,
--  f_ftf_l3."l3_pgname"      as "l3_pgname"     ,
--  f_ftf_l3."l3_flowid"      as "l3_flowid"     , 
--  f_ftf_l3."l3_inputid"     as "l3_inputid"    ,
--  f_ftf_l3."l3_sourceid"    as "l3_sourceid"   ,
--  f_ftf_l3."l3_inputname"   as "l3_inputname"  ,
--  f_ftf_l3."l3_targetid"    as "l3_targetid"   ,
--  f_ftf_l3."l3_outputname"  as "l3_outputname" ,
-- count(*) 
-- from f_fieldtofield_l3 f_ftf_l3 
-- group by 
--  f_ftf_l3."l1_pgid"        ,
--  f_ftf_l3."l1_pgname"      ,
--  f_ftf_l3."l1_flowid"      ,         
--  f_ftf_l3."l1_inputid"     ,
--  f_ftf_l3."l1_sourceid"    ,
--  f_ftf_l3."l1_inputname"   ,
--  f_ftf_l3."l1_targetid"    ,
--  f_ftf_l3."l1_outputname"  ,
--  f_ftf_l3."l2_pgid"        ,
--  f_ftf_l3."l2_pgname"      ,
--  f_ftf_l3."l2_flowid"      ,
--  f_ftf_l3."l2_inputid"     ,
--  f_ftf_l3."l2_sourceid"    ,
--  f_ftf_l3."l2_inputname"   ,
--  f_ftf_l3."l2_targetid"    ,
--  f_ftf_l3."l2_outputname"  ,
--  f_ftf_l3."l3_pgid"        ,
--  f_ftf_l3."l3_pgname"      ,
--  f_ftf_l3."l3_flowid"      , 
--  f_ftf_l3."l3_inputid"     ,
--  f_ftf_l3."l3_sourceid"    ,
--  f_ftf_l3."l3_inputname"   ,
--  f_ftf_l3."l3_targetid"    ,
--  f_ftf_l3."l3_outputname"   
-- having count(*) > 1
-- order by 2 , 1 , 3 , 8 , 7 , 9 , 14 , 13 , 15;
--
create index f_fieldtofield_l3_i0 on f_fieldtofield_l3 ("l3_targetid");
create index f_fieldtofield_l3_i1 on f_fieldtofield_l3 ("l1_flowid");
create index f_fieldtofield_l3_i2 on f_fieldtofield_l3 ("l2_flowid");
create index f_fieldtofield_l3_i3 on f_fieldtofield_l3 ("l3_flowid");
create index f_fieldtofield_l3_i4 on f_fieldtofield_l3 ("l1_inputid");
create index f_fieldtofield_l3_i5 on f_fieldtofield_l3 ("l2_inputid");
create index f_fieldtofield_l3_i6 on f_fieldtofield_l3 ("l3_inputid");
--

drop table f_fieldtofield_l4z;
drop table f_fieldtofield_l4;

create table f_fieldtofield_l4z as
select 
 f_ftf_l3."l1_pgid"        as "l1_pgid"       ,
 f_ftf_l3."l1_pgname"      as "l1_pgname"     ,
 f_ftf_l3."l1_flowid"      as "l1_flowid"     ,         
 f_ftf_l3."l1_inputid"     as "l1_inputid"    ,
 f_ftf_l3."l1_sourceid"    as "l1_sourceid"   ,
 f_ftf_l3."l1_inputname"   as "l1_inputname"  ,
 f_ftf_l3."l1_targetid"    as "l1_targetid"   ,
 f_ftf_l3."l1_outputname"  as "l1_outputname" ,
 f_ftf_l3."l2_pgid"        as "l2_pgid"       ,
 f_ftf_l3."l2_pgname"      as "l2_pgname"     ,
 f_ftf_l3."l2_flowid"      as "l2_flowid"     ,
 f_ftf_l3."l2_inputid"     as "l2_inputid"    ,
 f_ftf_l3."l2_sourceid"    as "l2_sourceid"   ,
 f_ftf_l3."l2_inputname"   as "l2_inputname"  ,
 f_ftf_l3."l2_targetid"    as "l2_targetid"   ,
 f_ftf_l3."l2_outputname"  as "l2_outputname" ,
 f_ftf_l3."l3_pgid"        as "l3_pgid"       ,
 f_ftf_l3."l3_pgname"      as "l3_pgname"     ,
 f_ftf_l3."l3_flowid"      as "l3_flowid"     , 
 f_ftf_l3."l3_inputid"     as "l3_inputid"    ,
 f_ftf_l3."l3_sourceid"    as "l3_sourceid"   ,
 f_ftf_l3."l3_inputname"   as "l3_inputname"  ,
 f_ftf_l3."l3_targetid"    as "l3_targetid"   ,
 f_ftf_l3."l3_outputname"  as "l3_outputname" ,  
 ftf.flow_id               as "l4_flowid"     , 
 ftf.input_id              as "l4_inputid"    ,
 ftf.source_id             as "l4_sourceid"   ,
 ftf.target_id             as "l4_targetid"
from
 f_fieldtofield_l3 f_ftf_l3 left outer join public.fieldtofield ftf
                      on   (f_ftf_l3."l3_targetid" = ftf.source_id
                            and not ((f_ftf_l3."l1_flowid"  = ftf.flow_id and f_ftf_l3."l1_inputid" = ftf.input_id)
                            or       (f_ftf_l3."l2_flowid"  = ftf.flow_id and f_ftf_l3."l2_inputid" = ftf.input_id)
                            or       (f_ftf_l3."l3_flowid"  = ftf.flow_id and f_ftf_l3."l3_inputid" = ftf.input_id)
							        )
                           )
order by 2 , 1 , 3 , 8 , 7 , 9 , 14 , 13 , 15;

--
create table f_fieldtofield_l4 as
select 
 f_ftf_l4z."l1_pgid"        as "l1_pgid"       ,
 f_ftf_l4z."l1_pgname"      as "l1_pgname"     ,
 f_ftf_l4z."l1_flowid"      as "l1_flowid"     ,         
 f_ftf_l4z."l1_inputid"     as "l1_inputid"    ,
 f_ftf_l4z."l1_sourceid"    as "l1_sourceid"   ,
 f_ftf_l4z."l1_inputname"   as "l1_inputname"  ,
 f_ftf_l4z."l1_targetid"    as "l1_targetid"   ,
 f_ftf_l4z."l1_outputname"  as "l1_outputname" ,
 f_ftf_l4z."l2_pgid"        as "l2_pgid"       ,
 f_ftf_l4z."l2_pgname"      as "l2_pgname"     ,
 f_ftf_l4z."l2_flowid"      as "l2_flowid"     ,
 f_ftf_l4z."l2_inputid"     as "l2_inputid"    ,
 f_ftf_l4z."l2_sourceid"    as "l2_sourceid"   ,
 f_ftf_l4z."l2_inputname"   as "l2_inputname"  ,
 f_ftf_l4z."l2_targetid"    as "l2_targetid"   ,
 f_ftf_l4z."l2_outputname"  as "l2_outputname" ,
 f_ftf_l4z."l3_pgid"        as "l3_pgid"       ,
 f_ftf_l4z."l3_pgname"      as "l3_pgname"     ,
 f_ftf_l4z."l3_flowid"      as "l3_flowid"     , 
 f_ftf_l4z."l3_inputid"     as "l3_inputid"    ,
 f_ftf_l4z."l3_sourceid"    as "l3_sourceid"   ,
 f_ftf_l4z."l3_inputname"   as "l3_inputname"  ,
 f_ftf_l4z."l3_targetid"    as "l3_targetid"   ,
 f_ftf_l4z."l3_outputname"  as "l3_outputname" ,  
 pg.id                      as "l4_pgid"       ,
 pg.name                    as "l4_pgname"     ,
 f_ftf_l4z."l4_flowid"      as "l4_flowid"     , 
 f_ftf_l4z."l4_inputid"     as "l4_inputid"    ,
 f_ftf_l4z."l4_sourceid"    as "l4_sourceid"   ,
 t1.name                    as "l4_inputname"  ,
 f_ftf_l4z."l4_targetid"    as "l4_targetid"   ,
 t2.name                    as "l4_outputname"  
from
 f_fieldtofield_l4z f_ftf_l4z left outer join public.type t1 on (f_ftf_l4z."l4_sourceid" = t1.id)
                              left outer join public.type t2 on (f_ftf_l4z."l4_targetid" = t2.id) ,
 public.program_flow pf ,
 public.program pg
where f_ftf_l4z."l4_flowid" = pf.flow 
and   pf.program            = pg.id
order by 2 , 1 , 3 , 8 , 7 , 9 , 14 , 13 , 15;

-- select
--  f_ftf_l4."l1_pgid"        as "l1_pgid"       ,
--  f_ftf_l4."l1_pgname"      as "l1_pgname"     ,
--  f_ftf_l4."l1_flowid"      as "l1_flowid"     ,         
--  f_ftf_l4."l1_inputid"     as "l1_inputid"    ,
--  f_ftf_l4."l1_sourceid"    as "l1_sourceid"   ,
--  f_ftf_l4."l1_inputname"   as "l1_inputname"  ,
--  f_ftf_l4."l1_targetid"    as "l1_targetid"   ,
--  f_ftf_l4."l1_outputname"  as "l1_outputname" ,
--  f_ftf_l4."l2_pgid"        as "l2_pgid"       ,
--  f_ftf_l4."l2_pgname"      as "l2_pgname"     ,
--  f_ftf_l4."l2_flowid"      as "l2_flowid"     ,
--  f_ftf_l4."l2_inputid"     as "l2_inputid"    ,
--  f_ftf_l4."l2_sourceid"    as "l2_sourceid"   ,
--  f_ftf_l4."l2_inputname"   as "l2_inputname"  ,
--  f_ftf_l4."l2_targetid"    as "l2_targetid"   ,
--  f_ftf_l4."l2_outputname"  as "l2_outputname" ,
--  f_ftf_l4."l3_pgid"        as "l3_pgid"       ,
--  f_ftf_l4."l3_pgname"      as "l3_pgname"     ,
--  f_ftf_l4."l3_flowid"      as "l3_flowid"     , 
--  f_ftf_l4."l3_inputid"     as "l3_inputid"    ,
--  f_ftf_l4."l3_sourceid"    as "l3_sourceid"   ,
--  f_ftf_l4."l3_inputname"   as "l3_inputname"  ,
--  f_ftf_l4."l3_targetid"    as "l3_targetid"   ,
--  f_ftf_l4."l3_outputname"  as "l3_outputname" ,
--  f_ftf_l4."l4_pgid"        as "l4_pgid"       ,
--  f_ftf_l4."l4_pgname"      as "l4_pgname"     ,
--  f_ftf_l4."l4_flowid"      as "l4_flowid"     , 
--  f_ftf_l4."l4_inputid"     as "l4_inputid"    ,
--  f_ftf_l4."l4_sourceid"    as "l4_sourceid"   ,
--  f_ftf_l4."l4_inputname"   as "l4_inputname"  ,
--  f_ftf_l4."l4_targetid"    as "l4_targetid"   ,
--  f_ftf_l4."l4_outputname"  as "l4_outputname" ,
-- count(*) 
-- from f_fieldtofield_l4 f_ftf_l4 
-- group by 
--  f_ftf_l4."l1_pgid"        ,
--  f_ftf_l4."l1_pgname"      ,
--  f_ftf_l4."l1_flowid"      ,         
--  f_ftf_l4."l1_inputid"     ,
--  f_ftf_l4."l1_sourceid"    ,
--  f_ftf_l4."l1_inputname"   ,
--  f_ftf_l4."l1_targetid"    ,
--  f_ftf_l4."l1_outputname"  ,
--  f_ftf_l4."l2_pgid"        ,
--  f_ftf_l4."l2_pgname"      ,
--  f_ftf_l4."l2_flowid"      ,
--  f_ftf_l4."l2_inputid"     ,
--  f_ftf_l4."l2_sourceid"    ,
--  f_ftf_l4."l2_inputname"   ,
--  f_ftf_l4."l2_targetid"    ,
--  f_ftf_l4."l2_outputname"  ,
--  f_ftf_l4."l3_pgid"        ,
--  f_ftf_l4."l3_pgname"      ,
--  f_ftf_l4."l3_flowid"      , 
--  f_ftf_l4."l3_inputid"     ,
--  f_ftf_l4."l3_sourceid"    ,
--  f_ftf_l4."l3_inputname"   ,
--  f_ftf_l4."l3_targetid"    ,
--  f_ftf_l4."l3_outputname"  , 
--  f_ftf_l4."l4_pgid"        ,
--  f_ftf_l4."l4_pgname"      ,
--  f_ftf_l4."l4_flowid"      , 
--  f_ftf_l4."l4_inputid"     ,
--  f_ftf_l4."l4_sourceid"    ,
--  f_ftf_l4."l4_inputname"   ,
--  f_ftf_l4."l4_targetid"    ,
--  f_ftf_l4."l4_outputname"   
-- having count(*) > 1
-- order by 2 , 1 , 3 , 8 , 7 , 9 , 14 , 13 , 15 , 26 , 25 , 27;

