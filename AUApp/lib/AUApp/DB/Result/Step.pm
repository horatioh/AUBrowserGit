use utf8;
package AUApp::DB::Result::Step;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Step

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

=head1 TABLE: C<step>

=cut

__PACKAGE__->table("step");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 line

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 operation_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 transform

  data_type: 'boolean'
  is_nullable: 0

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 flow

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 parent_step

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 result

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 succession

  data_type: 'integer'
  is_nullable: 1

=head2 step

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "line",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "operation_type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "transform",
  { data_type => "boolean", is_nullable => 0 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "flow",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "parent_step",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "result",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "succession",
  { data_type => "integer", is_nullable => 1 },
  "step",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 flow

Type: belongs_to

Related object: L<AUApp::DB::Result::Flow>

=cut

__PACKAGE__->belongs_to(
  "flow",
  "AUApp::DB::Result::Flow",
  { id => "flow" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 parent_step

Type: belongs_to

Related object: L<AUApp::DB::Result::Step>

=cut

__PACKAGE__->belongs_to(
  "parent_step",
  "AUApp::DB::Result::Step",
  { id => "parent_step" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 result

Type: belongs_to

Related object: L<AUApp::DB::Result::Type>

=cut

__PACKAGE__->belongs_to(
  "result",
  "AUApp::DB::Result::Type",
  { id => "result" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 step_conditions

Type: has_many

Related object: L<AUApp::DB::Result::StepCondition>

=cut

__PACKAGE__->has_many(
  "step_conditions",
  "AUApp::DB::Result::StepCondition",
  { "foreign.step_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 steps

Type: has_many

Related object: L<AUApp::DB::Result::Step>

=cut

__PACKAGE__->has_many(
  "steps",
  "AUApp::DB::Result::Step",
  { "foreign.parent_step" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YUvQfrzIH5TeGf7APIz2Pw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
