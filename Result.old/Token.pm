use utf8;
package AUApp::DB::Result::Token;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("token");
__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "column_of_line",
  { data_type => "integer", is_nullable => 0 },
  "line",
  { data_type => "integer", is_nullable => 0 },
  "text",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "type",
  { data_type => "integer", is_nullable => 0 },
  "typename",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "parent",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "succession",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->has_many(
  "dynamiccalls",
  "AUApp::DB::Result::Dynamiccall",
  { "foreign.statement_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "parent",
  "AUApp::DB::Result::Token",
  { id => "parent" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->has_many(
  "program_calls",
  "AUApp::DB::Result::ProgramCall",
  { "foreign.statement_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_statements",
  "AUApp::DB::Result::ProgramStatement",
  { "foreign.statement_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "programs_using",
  "AUApp::DB::Result::ProgramUsing",
  { "foreign.statement_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->might_have(
  "step_condition",
  "AUApp::DB::Result::StepCondition",
  { "foreign.conditions_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "tokens",
  "AUApp::DB::Result::Token",
  { "foreign.parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8HOL9T2JSQxTHTF6UL/YdQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
