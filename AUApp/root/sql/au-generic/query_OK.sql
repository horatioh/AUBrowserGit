SELECT "me"."record", "me"."io_type", "me"."id", "me"."name", "me"."uri", "me"."version", "me"."library", "me"."measure", 
  (SELECT COUNT( * ) FROM "program_input" "program_inputs_alias" WHERE ( "program_inputs_alias"."input" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "fieldtofield" "fieldtofields_alias" WHERE ( "fieldtofields_alias"."input_id" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "logical_physical" "logical_physical_physicals_alias" WHERE ( "logical_physical_physicals_alias"."physical" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "flow_input" "flow_inputs_alias" WHERE ( "flow_inputs_alias"."input" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "flow" "flows_alias" WHERE ( "flows_alias"."output" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "program_output" "program_outputs_alias" WHERE ( "program_outputs_alias"."output" = "me"."id" )), 
  (SELECT COUNT( * ) FROM "logical_physical" "logical_physical_logicals_alias" WHERE ( "logical_physical_logicals_alias"."logical" = "me"."id" )), 
  "record"."id", "library"."id", "measure"."id", "dli_database"."id", "indexed_sequential"."id", "rdbms_table"."id", "ddm"."id", "sequential"."id", "printer"."id", "screen"."id" 
FROM "input_output" "me" 
  LEFT JOIN "measure" "measure" ON "measure"."id" = "me"."measure" 
  LEFT JOIN "abstractlibrary" "library" ON "library"."id" = "me"."library" 
  LEFT JOIN "screen" "screen" ON "screen"."id" = "me"."id" 
  LEFT JOIN "indexed_sequential" "indexed_sequential" ON "indexed_sequential"."id" = "me"."id" 
  LEFT JOIN "rdbms_table" "rdbms_table" ON "rdbms_table"."id" = "me"."id" 
  LEFT JOIN "dli_database" "dli_database" ON "dli_database"."id" = "me"."id" 
  LEFT JOIN "ddm" "ddm" ON "ddm"."id" = "me"."id" 
  LEFT JOIN "sequential" "sequential" ON "sequential"."id" = "me"."id" 
  LEFT JOIN "printer" "printer" ON "printer"."id" = "me"."id" 
  LEFT JOIN "type" "record" ON "record"."id" = "me"."record" 
WHERE ( "me"."record" = ? ) LIMIT ?: '19471', '25'