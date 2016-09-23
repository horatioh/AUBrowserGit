use utf8;
package AUApp::DB::Result::Token;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Token

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

=head1 TABLE: C<token>

=cut

__PACKAGE__->table("token");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 column_of_line

  data_type: 'integer'
  is_nullable: 0

=head2 line

  data_type: 'integer'
  is_nullable: 0

=head2 text

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 type

  data_type: 'integer'
  is_nullable: 0

=head2 typename

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 parent

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 succession

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "column_of_line",
  { data_type => "integer", is_nullable => 0 },
  "line",
  { data_type => "integer", is_nullable => 0 },
  "text",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "type",
  { data_type => "integer", is_nullable => 0 },
  "typename",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "parent",
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

=head2 dynamiccalls

Type: has_many

Related object: L<AUApp::DB::Result::Dynamiccall>

=cut

__PACKAGE__->has_many(
  "dynamiccalls",
  "AUApp::DB::Result::Dynamiccall",
  { "foreign.statement_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 parent

Type: belongs_to

Related object: L<AUApp::DB::Result::Token>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "AUApp::DB::Result::Token",
  { id => "parent" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 program_calls

Type: has_many

Related object: L<AUApp::DB::Result::ProgramCall>

=cut

__PACKAGE__->has_many(
  "program_calls",
  "AUApp::DB::Result::ProgramCall",
  { "foreign.statement_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 programs_using

Type: has_many

Related object: L<AUApp::DB::Result::ProgramUsing>

=cut

__PACKAGE__->has_many(
  "programs_using",
  "AUApp::DB::Result::ProgramUsing",
  { "foreign.statement_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 step_condition

Type: might_have

Related object: L<AUApp::DB::Result::StepCondition>

=cut

__PACKAGE__->might_have(
  "step_condition",
  "AUApp::DB::Result::StepCondition",
  { "foreign.conditions_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 tokens

Type: has_many

Related object: L<AUApp::DB::Result::Token>

=cut

__PACKAGE__->has_many(
  "tokens",
  "AUApp::DB::Result::Token",
  { "foreign.parent" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RubRTRN/LAbytlgP5qtW2w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
