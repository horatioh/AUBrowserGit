-- View: public.v_outflowin

-- DROP VIEW public.v_outflowin;

CREATE OR REPLACE VIEW public.v_outflowin AS 
 SELECT "out".name AS output,
    flow.id AS f_id,
    program.name AS program,
    "in".name AS input,
    flow.output AS o_id,
    flow_input.input AS i_id,
    program_flow.program AS p_id
   FROM program,
    input_output "out",
    flow,
    program_flow,
    flow_input,
    input_output "in"
  WHERE "out".id = flow.output AND flow.id = program_flow.flow AND flow.id = flow_input.flow AND program_flow.program = program.id AND flow_input.input = "in".id
  ORDER BY "out".name, flow.id;

ALTER TABLE public.v_outflowin
  OWNER TO postgres;
COMMENT ON VIEW public.v_outflowin
  IS 'View for output flow input ';
