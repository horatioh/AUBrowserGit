use utf8;
package AUApp::DB::Result::StepCondition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("step_condition");
__PACKAGE__->add_columns(
  "step_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "conditions_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "depth",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("step_id", "depth");
__PACKAGE__->add_unique_constraint("uk_sobmvd5hx9weyxpuk5keva3pd", ["conditions_id"]);
__PACKAGE__->belongs_to(
  "condition",
  "AUApp::DB::Result::Token",
  { id => "conditions_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
__PACKAGE__->belongs_to(
  "step",
  "AUApp::DB::Result::Step",
  { id => "step_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+rd1qkrvXn6+gbX4iRWQlw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;