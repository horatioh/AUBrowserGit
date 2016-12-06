--
-- ----------------------------------------------------------------------------------------
-- (-1) Ausschluss nicht benötigten Programme
-- ----------------------------------------------------------------------------------------
--
insert into exclude_pgm values (12385);
delete from exclude_pgm;
--
-- ----------------------------------------------------------------------------------------
-- (0) Drop Zwischentabellen
-- ----------------------------------------------------------------------------------------
--
drop table if exists l1;
drop table if exists l2;
drop table if exists l3;
drop table if exists l4;
drop table if exists l5;
drop table if exists l6;
drop table if exists l7;
drop table if exists l8;
drop table if exists l9;
drop table if exists l10;
drop table if exists l11;
drop table if exists l_all;
drop table if exists f_fieldtofield_input_result;
--
-- ----------------------------------------------------------------------------------------
-- (1) Afbau Tabelle level 1
-- ----------------------------------------------------------------------------------------
--
create table l1 as
select 
 CAST(1 AS INT)        as Level         , 
 el.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 entry_level_input     as el            , 
 f_fieldtofield        as f2f 
where el.input_feld_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
group by 
 el.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (2) Afbau Tabelle level 2
-- ----------------------------------------------------------------------------------------
--
create table l2 as
select
 CAST(2 AS INT)        as Level         , 
 l1.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l1                                     , 
 f_fieldtofield f2f
where l1.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
group by 
 l1.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (3) Afbau Tabelle level 3
-- ----------------------------------------------------------------------------------------
--
create table l3 as
select
 CAST(3 AS INT)        as Level         , 
 l2.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l2                                     , 
 f_fieldtofield f2f
where l2.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
group by 
 l2.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (4) Afbau Tabelle level 4
-- ----------------------------------------------------------------------------------------
--
create table l4 as
select
 CAST(4 AS INT)        as Level         , 
 l3.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l3                                     , 
 f_fieldtofield f2f
where l3.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
group by 
 l3.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (5) Afbau Tabelle level 5
-- ----------------------------------------------------------------------------------------
--
create table l5 as
select
 CAST(5 AS INT)        as Level         , 
 l4.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l4                                     , 
 f_fieldtofield f2f
where l4.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
and   not exists (select 0 from l4             where l4.program_id  = f2f.program_id)
group by 
 l4.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (6) Afbau Tabelle level 6
-- ----------------------------------------------------------------------------------------
--
create table l6 as
select
 CAST(6 AS INT)        as Level         , 
 l5.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l5                                     , 
 f_fieldtofield f2f
where l5.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
and   not exists (select 0 from l4             where l4.program_id  = f2f.program_id)
and   not exists (select 0 from l5             where l5.program_id  = f2f.program_id)
group by 
 l5.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (7) Afbau Tabelle level 7
-- ----------------------------------------------------------------------------------------
--
create table l7 as
select
 CAST(7 AS INT)        as Level         , 
 l6.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l6                                     , 
 f_fieldtofield f2f
where l6.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
and   not exists (select 0 from l4             where l4.program_id  = f2f.program_id)
and   not exists (select 0 from l5             where l5.program_id  = f2f.program_id)
and   not exists (select 0 from l6             where l6.program_id  = f2f.program_id)
group by 
 l6.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (8) Afbau Tabelle level 8
-- ----------------------------------------------------------------------------------------
--
create table l8 as
select
 CAST(8 AS INT)        as Level         , 
 l7.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l7                                     , 
 f_fieldtofield f2f
where l7.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
and   not exists (select 0 from l4             where l4.program_id  = f2f.program_id)
and   not exists (select 0 from l5             where l5.program_id  = f2f.program_id)
and   not exists (select 0 from l6             where l6.program_id  = f2f.program_id)
and   not exists (select 0 from l7             where l7.program_id  = f2f.program_id)
group by 
 l7.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (9) Afbau Tabelle level 9
-- ----------------------------------------------------------------------------------------
--
create table l9 as
select
 CAST(9 AS INT)        as Level         , 
 l8.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l8                                     , 
 f_fieldtofield f2f
where l8.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
and   not exists (select 0 from l4             where l4.program_id  = f2f.program_id)
and   not exists (select 0 from l5             where l5.program_id  = f2f.program_id)
and   not exists (select 0 from l6             where l6.program_id  = f2f.program_id)
and   not exists (select 0 from l7             where l7.program_id  = f2f.program_id)
and   not exists (select 0 from l8             where l8.program_id  = f2f.program_id)
group by 
 l8.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (10) Afbau Tabelle level 10
-- ----------------------------------------------------------------------------------------
--
create table l10 as
select
 CAST(10 AS INT)       as Level         , 
 l9.input_feld_id      as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l9                                     , 
 f_fieldtofield f2f
where l9.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
and   not exists (select 0 from l4             where l4.program_id  = f2f.program_id)
and   not exists (select 0 from l5             where l5.program_id  = f2f.program_id)
and   not exists (select 0 from l6             where l6.program_id  = f2f.program_id)
and   not exists (select 0 from l7             where l7.program_id  = f2f.program_id)
and   not exists (select 0 from l8             where l8.program_id  = f2f.program_id)
and   not exists (select 0 from l9             where l9.program_id  = f2f.program_id)
group by 
 l9.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (11) Afbau Tabelle level 11
-- ----------------------------------------------------------------------------------------
--
create table l11 as
select
 CAST(11 AS INT)       as Level         , 
 l10.input_feld_id     as input_feld_id ,
 f2f.id                as id            ,
 f2f.program_id        as program_id    , 
 f2f.flow_id           as flow_id       , 
 f2f.input_id          as input_id      , 
 f2f.source_id         as source_id     , 
 f2f.output_id         as output_id     ,
 f2f.target_id         as target_id
from 
 l10                                    , 
 f_fieldtofield f2f
where l10.target_id = f2f.source_id
and   not exists (select 0 from exclude_pgm ep where f2f.program_id = ep.id)
and   not exists (select 0 from l1             where l1.program_id  = f2f.program_id)
and   not exists (select 0 from l2             where l2.program_id  = f2f.program_id)
and   not exists (select 0 from l3             where l3.program_id  = f2f.program_id)
and   not exists (select 0 from l4             where l4.program_id  = f2f.program_id)
and   not exists (select 0 from l5             where l5.program_id  = f2f.program_id)
and   not exists (select 0 from l6             where l6.program_id  = f2f.program_id)
and   not exists (select 0 from l7             where l7.program_id  = f2f.program_id)
and   not exists (select 0 from l8             where l8.program_id  = f2f.program_id)
and   not exists (select 0 from l9             where l9.program_id  = f2f.program_id)
and   not exists (select 0 from l10            where l10.program_id = f2f.program_id)
group by 
 l10.input_feld_id                       ,
 f2f.id                                 ,
 f2f.program_id                         , 
 f2f.flow_id                            , 
 f2f.input_id                           , 
 f2f.source_id                          , 
 f2f.output_id                          ,
 f2f.target_id                         
order by 2, 5 , 6 , 7;
--
-- ----------------------------------------------------------------------------------------
-- (12) Afbau Result Tabele
-- ----------------------------------------------------------------------------------------
--
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
union
select * from l9
union
select * from l10
union
select * from l11
order by 1 , 3 , 2 , 4 , 5;
--
create table f_fieldtofield_input_result as
select
 l.level         as level ,
 l.input_feld_id as input_feld_id ,
 t.name          as input_feld_name,
 pg.id           as program_id,
 pg.name         as program_name ,
 pg.uri          as program_uri ,
 l.flow_id       as flow_id ,
 l.input_id      as input_id ,
 io.name         as input_file_name ,
 io.uri          as input_uri ,
 l.source_id     as source_id ,
 t1.name         as source_feld_name ,
 l.output_id     as output_id ,       
 oi.name         as output_file_name ,
 oi.uri          as output_uri ,
 l.target_id     as target_id ,
 t2.name         as target_feld_name
from
 l_all               l  ,
 public.type         t  ,
 public.input_output io ,
 public.type         t1 ,
 public.type         t2 ,
 public.program_flow pf ,
 public.program      pg ,
 public.input_output oi
where l.input_feld_id = t.id
and   l.input_id      = io.id
and   l.source_id     = t1.id
and   l.target_id     = t2.id
and   l.flow_id       = pf.flow
and   pf.program      = pg.id
and   l.output_id     = oi.id
order by l.level ,  l.flow_id , l.input_id , l.source_id , l.target_id
;
