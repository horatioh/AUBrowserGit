



SELECT 
  "out".name AS output, 
  flow.id AS f_id, 
  program.name AS program, 
  "in".name AS input, 
  flow.output AS o_id, 
  flow_input.input AS i_id, 
  program_flow.program AS p_id
FROM 
  public.program, 
  public.input_output "out", 
  public.flow, 
  public.program_flow, 
  public.flow_input, 
  public.input_output "in"
WHERE 
  "out".id = flow.output AND
  flow.id = program_flow.flow AND
  flow.id = flow_input.flow AND
  program_flow.program = program.id AND
  flow_input.input = "in".id
ORDER BY
  "out".name ASC, 
  flow.id ASC;
