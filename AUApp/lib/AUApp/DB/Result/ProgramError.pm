use utf8;
package AUApp::DB::Result::ProgramError;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("program_error");
__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "line",
  { data_type => "integer", is_nullable => 1 },
  "message",
  { data_type => "varchar", is_nullable => 0, size => 32767 },
  "position",
  { data_type => "integer", is_nullable => 1 },
  "program",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "program",
  "AUApp::DB::Result::Program",
  { id => "program" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JoxuPJTDeWPYZZ4SSFpodw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
