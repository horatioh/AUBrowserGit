use utf8;
package AUApp::DB::Result::Superdescriptor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("superdescriptor");
__PACKAGE__->add_columns(
  "ddm",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "structure",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "succession",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("ddm", "succession");
__PACKAGE__->add_unique_constraint("uk_1lyr708c0p67womq4bm39cl7p", ["structure"]);
__PACKAGE__->belongs_to(
  "ddm",
  "AUApp::DB::Result::Ddm",
  { id => "ddm" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
__PACKAGE__->belongs_to(
  "structure",
  "AUApp::DB::Result::Type",
  { id => "structure" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:gyA3FvHF4mGnzuDU2xlJJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
