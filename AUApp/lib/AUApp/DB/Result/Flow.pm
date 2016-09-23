use utf8;
package AUApp::DB::Result::Flow;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Flow

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

=head1 TABLE: C<flow>

=cut

__PACKAGE__->table("flow");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 output

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "output",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 fieldtofields

Type: has_many

Related object: L<AUApp::DB::Result::Fieldtofield>

=cut

__PACKAGE__->has_many(
  "fieldtofields",
  "AUApp::DB::Result::Fieldtofield",
  { "foreign.flow_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 flow_inputs

Type: has_many

Related object: L<AUApp::DB::Result::FlowInput>

=cut

__PACKAGE__->has_many(
  "flow_inputs",
  "AUApp::DB::Result::FlowInput",
  { "foreign.flow" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 output

Type: belongs_to

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->belongs_to(
  "output",
  "AUApp::DB::Result::InputOutput",
  { id => "output" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 program_flows

Type: has_many

Related object: L<AUApp::DB::Result::ProgramFlow>

=cut

__PACKAGE__->has_many(
  "program_flows",
  "AUApp::DB::Result::ProgramFlow",
  { "foreign.flow" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 steps

Type: has_many

Related object: L<AUApp::DB::Result::Step>

=cut

__PACKAGE__->has_many(
  "steps",
  "AUApp::DB::Result::Step",
  { "foreign.flow" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:i/3NjKtvbDhvnsC+0LjTnw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
