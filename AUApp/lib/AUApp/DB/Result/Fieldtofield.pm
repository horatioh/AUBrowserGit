use utf8;
package AUApp::DB::Result::Fieldtofield;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("fieldtofield");
__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "source_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "target_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "flow_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "input_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->belongs_to(
  "flow",
  "AUApp::DB::Result::Flow",
  { id => "flow_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
__PACKAGE__->belongs_to(
  "input",
  "AUApp::DB::Result::InputOutput",
  { id => "input_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:T6eKDSzrxeiu0i0qcNWzzg

__PACKAGE__->belongs_to(
  "source",
  "AUApp::DB::Result::Type",
  { id => "source_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

__PACKAGE__->belongs_to(
  "target",
  "AUApp::DB::Result::Type",
  { id => "target_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
