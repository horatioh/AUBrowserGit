--
-- ----------------------------------------------------------------------------------------
-- (1) Aufbau der Zwischentabelle f_input_output 
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_input_output;
--
create table f_input_output as
select 
 CAST(io.id      AS INT)           as "io_id" ,
 CAST(io.name    AS VARCHAR(10))   as "io_name" ,
 CAST(io.io_type AS VARCHAR(10))   as "io_iotype" ,
 CAST(io.record  AS BIGINT)        as "io_recordid" ,
 CAST(io.uri     AS VARCHAR(100))  as "io_uri" 
from
 public.input_output io
where io.id not in (select id from not_used_input_output)
;
--
-- check: select * from f_input_output;
--
-- ----------------------------------------------------------------------------------------
-- (2) Aufbau der Zwischen-Tabelle f_type_d
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_type_d;
--
create table f_type_d as
--
select 
--
  fio."io_id"                      as "d_id" , 
  fio."io_name"                    as "d_name" , 
  fio."io_iotype"                  as "d_type" ,
  fio."io_recordid"                as "d_recordid" , 
  f.parent                         as "d_parent" ,
  f.succession                     as "d_succession" ,
  f.precision                      as "d_precision", 
--
  cast (null as bigint)            as "r_id" ,
  cast (null as character varying) as "r_name" ,
  cast (null as character varying) as "r_type" ,
  cast (null as bigint)            as "r_parent" ,
  cast (null as integer)           as "r_succession",
  cast (null as integer)           as "r_precision" ,
--
  cast (null as bigint)            as "f_id" ,
  cast (null as character varying) as "f_name" ,
  cast (null as character varying) as "f_type",
  cast (null as bigint)            as "f_parent",
  cast (null as integer)           as "f_succession",
  cast (null as integer)           as "f_precision" ,
--
  fio."io_uri"
--
from f_input_output fio, public.type f
--
where fio."io_recordid" = f.id
and f.parent is null;
--
update f_type_d set ("d_succession" , "d_parent" ,"r_succession" , "r_parent" ,"f_succession" , "f_parent" ) = (-1 , -1 , -1 , -1 , -1 , -1  );
--
-- check: select * from f_type_d order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_name" , "r_succession" , "f_parent" , "f_name" , "f_succession";

-- ----------------------------------------------------------------------------------------
-- (3) Aufbau der Zwischen-Tabelle f_type_r
-- ----------------------------------------------------------------------------------------
--
drop table if exists f_type_rz;
create table f_type_rz as
--
select 
--
  ftd."d_id" , 
  ftd."d_name" , 
  ftd."d_type" , 
  ftd."d_recordid" , 
  ftd."d_parent" ,
  ftd."d_succession" ,
  ftd."d_precision", 
--
  t.id                             as "r_id" ,
  t.name                           as "r_name" ,
  t.type                           as "r_type" ,
  t.parent                         as "r_parent" ,
  t.succession                     as "r_succession",
  t.precision                      as "r_precision" ,
--
  cast (null as bigint)            as "f_id" ,
  cast (null as character varying) as "f_name" ,
  cast (null as character varying) as "f_type",
  cast (null as bigint)            as "f_parent",
  cast (null as integer)           as "f_succession",
  cast (null as integer)           as "f_precision" ,
--
  ftd."io_uri"
--
from 
 f_type_d ftd left outer join public.type t on (t.parent = ftd."d_recordid" )
order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_id" , "r_succession" , "f_parent" , "f_id" , "f_succession";
--
update f_type_rz set (r_id, r_name, r_type , r_succession, r_precision) = (d_recordid,  d_name, null, 0, null) where r_type is not null;
--
drop table if exists f_type_r;
--
create table f_type_r as
--
select 
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
from
 f_type_rz ft
group by
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
order by 1,4,8,14;

-- check: select * from f_type_r order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_id" , "r_succession" , "f_parent" , "f_id" , "f_succession";

-- ----------------------------------------------------------------------------------------
-- (4) Aufbau der Zwischen-Tabelle f_type
-- ----------------------------------------------------------------------------------------

drop table if exists f_type;
--
create table f_type as
--
select 
--
  ftr."d_id" , 
  ftr."d_name" , 
  ftr."d_type" , 
  ftr."d_recordid" , 
  ftr."d_parent" ,
  ftr."d_succession" ,
  ftr."d_precision", 
--
  ftr."r_id" ,
  ftr."r_name" ,
  ftr."r_type" ,
  ftr."r_parent" ,
  ftr."r_succession",
  ftr."r_precision" ,
--
  t.id                as "f_id" ,
  t.name              as "f_name" ,
  t.type              as "f_type",
  t.parent            as "f_parent",
  t.succession        as "f_succession",
  t.precision         as "f_precision" , 
--
  ftr."io_uri"
--
from f_type_r ftr , public.type t 
--
where t.parent = ftr."r_id";

-- check: select * from f_type order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_id" , "r_succession" , "f_parent" , "f_id" , "f_succession";
