use utf8;
package AUApp::DB::Result::InputOutput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("input_output");
__PACKAGE__->add_columns(
  "io_type",
  { data_type => "varchar", is_nullable => 0, size => 8 },
  "id",
  { data_type => "bigint", is_nullable => 0 },
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
  "record",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("uk420h355gjp2ma90ceo3sjp2vp", ["library", "name"]);

__PACKAGE__->has_many(
  "fieldtofields",
  "AUApp::DB::Result::Fieldtofield",
  { "foreign.input_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "flow_inputs",
  "AUApp::DB::Result::FlowInput",
  { "foreign.input" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "flows",
  "AUApp::DB::Result::Flow",
  { "foreign.output" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->might_have(
  "indexed_sequential",
  "AUApp::DB::Result::IndexedSequential",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "library",
  "AUApp::DB::Result::Abstractlibrary",
  { id => "library" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
__PACKAGE__->has_many(
  "logical_physical_logicals",
  "AUApp::DB::Result::LogicalPhysical",
  { "foreign.logical" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "logical_physical_physicals",
  "AUApp::DB::Result::LogicalPhysical",
  { "foreign.physical" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
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
__PACKAGE__->might_have(
  "printer",
  "AUApp::DB::Result::Printer",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_inputs",
  "AUApp::DB::Result::ProgramInput",
  { "foreign.input" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "program_outputs",
  "AUApp::DB::Result::ProgramOutput",
  { "foreign.output" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "record",
  "AUApp::DB::Result::Type",
  { id => "record" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->might_have(
  "screen",
  "AUApp::DB::Result::Screen",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:b573ujC2N8AI4x2Ocy3jIg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
