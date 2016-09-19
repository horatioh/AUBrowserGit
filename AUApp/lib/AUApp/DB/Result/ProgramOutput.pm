use utf8;
package AUApp::DB::Result::ProgramOutput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("program_output");
__PACKAGE__->add_columns(
  "program",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "output",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->belongs_to(
  "output",
  "AUApp::DB::Result::InputOutput",
  { id => "output" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
__PACKAGE__->belongs_to(
  "program",
  "AUApp::DB::Result::Program",
  { id => "program" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vZpH5muGiBpt73WnTEJ9aw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
