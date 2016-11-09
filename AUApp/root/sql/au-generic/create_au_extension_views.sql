-- View: au_extension.v_fieldtofield

-- DROP VIEW au_extension.v_fieldtofield;

CREATE OR REPLACE VIEW au_extension.v_fieldtofield AS 
 SELECT fieldtofield.id,
    fieldtofield.flow_id,
    fieldtofield.input_id,
    fieldtofield.source_id,
    fieldtofield.target_id
   FROM fieldtofield;

ALTER TABLE au_extension.v_fieldtofield
  OWNER TO au;
-- View: au_extension.v_input_output

-- DROP VIEW au_extension.v_input_output;

CREATE OR REPLACE VIEW au_extension.v_input_output AS 
 SELECT input_output.io_type,
    input_output.id,
    input_output.name,
    input_output.uri,
    input_output.version,
    input_output.library,
    input_output.measure,
    input_output.record
   FROM input_output;

ALTER TABLE au_extension.v_input_output
  OWNER TO au;
-- View: au_extension.v_program

-- DROP VIEW au_extension.v_program;

CREATE OR REPLACE VIEW au_extension.v_program AS 
 SELECT program.id,
    program.alias_name,
    program.dialect,
    program.source_language,
    program.modifier,
    program.name,
    program.uri,
    program.version,
    program.library,
    program.measure
   FROM program;

ALTER TABLE au_extension.v_program
  OWNER TO au;
-- View: au_extension.v_type

-- DROP VIEW au_extension.v_type;

CREATE OR REPLACE VIEW au_extension.v_type AS 
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

ALTER TABLE au_extension.v_type
  OWNER TO au;
