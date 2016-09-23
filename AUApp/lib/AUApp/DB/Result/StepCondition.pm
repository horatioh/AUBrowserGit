use utf8;
package AUApp::DB::Result::StepCondition;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::StepCondition

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<step_condition>

=cut

__PACKAGE__->table("step_condition");

=head1 ACCESSORS

=head2 step_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 conditions_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 depth

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "step_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "conditions_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "depth",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</step_id>

=item * L</depth>

=back

=cut

__PACKAGE__->set_primary_key("step_id", "depth");

=head1 UNIQUE CONSTRAINTS

=head2 C<uk_sobmvd5hx9weyxpuk5keva3pd>

=over 4

=item * L</conditions_id>

=back

=cut

__PACKAGE__->add_unique_constraint("uk_sobmvd5hx9weyxpuk5keva3pd", ["conditions_id"]);

=head1 RELATIONS

=head2 condition

Type: belongs_to

Related object: L<AUApp::DB::Result::Token>

=cut

__PACKAGE__->belongs_to(
  "condition",
  "AUApp::DB::Result::Token",
  { id => "conditions_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 step

Type: belongs_to

Related object: L<AUApp::DB::Result::Step>

=cut

__PACKAGE__->belongs_to(
  "step",
  "AUApp::DB::Result::Step",
  { id => "step_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZHCVDMmWSOvrnJkJXd/+uQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
