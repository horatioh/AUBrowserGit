use utf8;
package AUApp::DB::Result::Type;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("type");
__PACKAGE__->add_columns(
  "record_type",
  { data_type => "varchar", is_nullable => 0, size => 3 },
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "declared_level",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "occurs",
  { data_type => "integer", is_nullable => 1 },
  "precision",
  { data_type => "integer", is_nullable => 1 },
  "scale",
  { data_type => "integer", is_nullable => 1 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "using_of_parameter",
  { data_type => "integer", is_nullable => 1 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "adabas_id",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "parent",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "physical",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "redefine",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "succession",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->might_have(
  "indice",
  "AUApp::DB::Result::Indices",
  { "foreign.structure" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "input_outputs",
  "AUApp::DB::Result::InputOutput",
  { "foreign.record" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "parent",
  "AUApp::DB::Result::Type",
  { id => "parent" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->belongs_to(
  "physical",
  "AUApp::DB::Result::Type",
  { id => "physical" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->belongs_to(
  "redefine",
  "AUApp::DB::Result::Type",
  { id => "redefine" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->has_many(
  "step_arguments",
  "AUApp::DB::Result::StepArgument",
  { "foreign.argument" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "steps",
  "AUApp::DB::Result::Step",
  { "foreign.result" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->might_have(
  "superdescriptor",
  "AUApp::DB::Result::Superdescriptor",
  { "foreign.structure" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "type_parents",
  "AUApp::DB::Result::Type",
  { "foreign.parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "type_physicals",
  "AUApp::DB::Result::Type",
  { "foreign.physical" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "type_redefines",
  "AUApp::DB::Result::Type",
  { "foreign.redefine" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "working_storages",
  "AUApp::DB::Result::WorkingStorage",
  { "foreign.structure" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N6aKVJQuvNAjJ2BWFXq8JQ

#__PACKAGE__->load_components("Tree::AdjacencyList");
#__PACKAGE__->parent_column("parent");
__PACKAGE__->has_many(
  "type_parents",
  "AUApp::DB::Result::VType",
  { "foreign.parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0},
);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
