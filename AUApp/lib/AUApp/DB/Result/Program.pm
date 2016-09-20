use utf8;
package AUApp::DB::Result::Program;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("program");
__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "alias_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "dialect",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "source_language",
  { data_type => "integer", is_nullable => 1 },
  "modifier",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "uri",
  { data_type => "varchar", is_nullable => 1, size => 32767 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "library",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "measure",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("ukshkho6dobona6vlk6wlwxr8r6", ["library", "name"]);
__PACKAGE__->has_many(
  "dynamiccalls",
  "AUApp::DB::Result::Dynamiccall",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "library",
  "AUApp::DB::Result::Abstractlibrary",
  { id => "library" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
__PACKAGE__->belongs_to(
  "measure",
  "AUApp::DB::Result::Measure",
  { id => "measure" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->has_many(
  "program_call_programs",
  "AUApp::DB::Result::ProgramCall",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_calls_called",
  "AUApp::DB::Result::ProgramCall",
  { "foreign.called" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_errors",
  "AUApp::DB::Result::ProgramError",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_flows",
  "AUApp::DB::Result::ProgramFlow",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_inputs",
  "AUApp::DB::Result::ProgramInput",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_outputs",
  "AUApp::DB::Result::ProgramOutput",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_statements",
  "AUApp::DB::Result::ProgramStatement",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_using_programs",
  "AUApp::DB::Result::ProgramUsing",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "programs_using_used",
  "AUApp::DB::Result::ProgramUsing",
  { "foreign.used" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ewFO1f5Qe9q1YcPpRkcoBQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
