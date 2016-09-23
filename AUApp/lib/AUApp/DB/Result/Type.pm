use utf8;
package AUApp::DB::Result::Type;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Type

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

=head1 TABLE: C<type>

=cut

__PACKAGE__->table("type");

=head1 ACCESSORS

=head2 record_type

  data_type: 'varchar'
  is_nullable: 0
  size: 3

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 declared_level

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 occurs

  data_type: 'integer'
  is_nullable: 1

=head2 precision

  data_type: 'integer'
  is_nullable: 1

=head2 scale

  data_type: 'integer'
  is_nullable: 1

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 using_of_parameter

  data_type: 'integer'
  is_nullable: 1

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 adabas_id

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 parent

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 physical

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 redefine

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 succession

  data_type: 'integer'
  is_nullable: 1

=cut

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

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 fieldtofield_sources

Type: has_many

Related object: L<AUApp::DB::Result::Fieldtofield>

=cut

__PACKAGE__->has_many(
  "fieldtofield_sources",
  "AUApp::DB::Result::Fieldtofield",
  { "foreign.source_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 fieldtofield_targets

Type: has_many

Related object: L<AUApp::DB::Result::Fieldtofield>

=cut

__PACKAGE__->has_many(
  "fieldtofield_targets",
  "AUApp::DB::Result::Fieldtofield",
  { "foreign.target_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 input_outputs

Type: has_many

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->has_many(
  "input_outputs",
  "AUApp::DB::Result::InputOutput",
  { "foreign.record" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 parent

Type: belongs_to

Related object: L<AUApp::DB::Result::Type>

=cut

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

=head2 physical

Type: belongs_to

Related object: L<AUApp::DB::Result::Type>

=cut

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

=head2 redefine

Type: belongs_to

Related object: L<AUApp::DB::Result::Type>

=cut

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

=head2 steps

Type: has_many

Related object: L<AUApp::DB::Result::Step>

=cut

__PACKAGE__->has_many(
  "steps",
  "AUApp::DB::Result::Step",
  { "foreign.result" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type_parents

Type: has_many

Related object: L<AUApp::DB::Result::Type>

=cut

__PACKAGE__->has_many(
  "type_parents",
  "AUApp::DB::Result::Type",
  { "foreign.parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type_physicals

Type: has_many

Related object: L<AUApp::DB::Result::Type>

=cut

__PACKAGE__->has_many(
  "type_physicals",
  "AUApp::DB::Result::Type",
  { "foreign.physical" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 type_redefines

Type: has_many

Related object: L<AUApp::DB::Result::Type>

=cut

__PACKAGE__->has_many(
  "type_redefines",
  "AUApp::DB::Result::Type",
  { "foreign.redefine" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LOplnQ5JzMl39mpW5eChgg

__PACKAGE__->has_many(
  "type_parents",
  "AUApp::DB::Result::VType",
  { "foreign.parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0},
);

__PACKAGE__->has_many(
  "type_physicals",
  "AUApp::DB::Result::VType",
  { "foreign.physical" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

__PACKAGE__->has_many(
  "type_redefines",
  "AUApp::DB::Result::VType",
  { "foreign.redefine" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
