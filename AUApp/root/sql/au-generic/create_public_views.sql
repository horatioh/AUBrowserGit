-- View: public.v_type

-- DROP VIEW public.v_type;

CREATE OR REPLACE VIEW public.v_type AS 
 SELECT type.record_type,
    type.id,
    type.declared_level,
    type.name,
    type.occurs,
    type."precision",
    type.scale,
    type.type,
    type.using_of_parameter,
    type.version,
    type.adabas_id,
    type.parent,
    type.physical,
    type.redefine,
    type.succession
   FROM type;

ALTER TABLE public.v_type
  OWNER TO au;
