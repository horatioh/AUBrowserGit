SELECT "me"."record_type", "me"."id", "me"."declared_level", "me"."name", "me"."occurs", "me"."precision", "me"."scale", "me"."type", "me"."using_of_parameter", "me"."version", "me"."adabas_id", "me"."parent", "me"."physical", "me"."redefine", "me"."succession", 
  (SELECT COUNT( * ) FROM "type" "type_redefines_alias" WHERE ( "type_redefines_alias"."redefine" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "step" "steps_alias" WHERE ( "steps_alias"."result" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "type" "type_physicals_alias" WHERE ( "type_physicals_alias"."physical" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "working_storage" "working_storages_alias" WHERE ( "working_storages_alias"."structure" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "type" "type_parents_alias" WHERE ( "type_parents_alias"."parent" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "input_output" "input_outputs_alias" WHERE ( "input_outputs_alias"."record" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "step_argument" "step_arguments_alias" WHERE ( "step_arguments_alias"."argument" = "me"."id" )), 
  "parent"."id", "physical"."id", "redefine"."id", "indice"."is_file", "indice"."structure", "superdescriptor"."ddm", "superdescriptor"."structure" 
  FROM "type" "me" 
    LEFT JOIN "type" "parent" ON "parent"."id" = "me"."parent" 
    LEFT JOIN "superdescriptor" "superdescriptor" ON "superdescriptor"."structure" = "me"."id" 
    LEFT JOIN "type" "redefine" ON "redefine"."id" = "me"."redefine" 
    LEFT JOIN "indices" "indice" ON "indice"."structure" = "me"."id" 
    LEFT JOIN "type" "physical" ON "physical"."id" = "me"."physical"
    LIMIT 25;