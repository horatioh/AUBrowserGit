--
-- ----------------------------------------------------------------------------------------
-- (1) aufbau der zwischentabelle f_input_output 
-- ----------------------------------------------------------------------------------------
--
drop table f_input_output;
--
create table f_input_output as
select 
 cast(io.id      as int)           as "io_id" ,
 cast(io.name    as varchar(10))   as "io_name" ,
 cast(io.io_type as varchar(10))   as "io_iotype" ,
 cast(io.record  as bigint)        as "io_recordid" ,
 cast(io.uri     as varchar(100))  as "io_uri" 
from
 public.input_output io
where io.id not in (select id from not_used_input_output)
;
--
-- check: select * from f_input_output;
--
-- ----------------------------------------------------------------------------------------
-- (2) aufbau der zwischen-tabelle f_type_d
-- ----------------------------------------------------------------------------------------
--
drop table f_type_d;
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
where fio."io_recordid" = f.id;
--
update f_type_d set ("d_succession" , "d_parent" ,"r_succession" , "r_parent" ,"f_succession" , "f_parent" ) = (-1 , -1 , -1 , -1 , -1 , -1  );
--
-- check: select * from f_type_d order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_id" , "r_succession" , "f_parent" , "f_id" , "f_succession";

-- ----------------------------------------------------------------------------------------
-- (3) aufbau der zwischen-tabelle f_type_r
-- ----------------------------------------------------------------------------------------
--
drop table f_type_r;
--
create table f_type_r as
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
from f_type_d ftd , public.type t 
--
where t.parent = ftd."d_recordid"
order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_id" , "r_succession" , "f_parent" , "f_id" , "f_succession";

-- check: select * from f_type_r order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_id" , "r_succession" , "f_parent" , "f_id" , "f_succession";

-- ----------------------------------------------------------------------------------------
-- (4) aufbau der zwischen-tabelle f_type
-- ----------------------------------------------------------------------------------------

drop table f_type;
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
  t.id                             as "f_id" ,
  t.name                           as "f_name" ,
  t.parent                         as "f_type",
  t.succession                     as "f_parent",
  t.type                           as "f_succession",
  t.precision                      as "f_precision" , 
--
  ftr."io_uri"
--
from f_type_r ftr , public.type t 
--
where t.parent = ftr."r_id";

-- check: select * from f_type order by "d_name" , "d_parent" , "d_succession" , "r_parent" , "r_id" , "r_succession" , "f_parent" , "f_id" , "f_succession";
