use utf8;
package AUApp::DB::Result::InputOutput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::InputOutput

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

=head1 TABLE: C<input_output>

=cut

__PACKAGE__->table("input_output");

=head1 ACCESSORS

=head2 io_type

  data_type: 'varchar'
  is_nullable: 0
  size: 8

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 uri

  data_type: 'varchar'
  is_nullable: 1
  size: 32767

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 library

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 measure

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 record

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "io_type",
  { data_type => "varchar", is_nullable => 0, size => 8 },
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "uri",
  { data_type => "varchar", is_nullable => 1, size => 32767 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "library",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "measure",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "record",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uk420h355gjp2ma90ceo3sjp2vp>

=over 4

=item * L</library>

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("uk420h355gjp2ma90ceo3sjp2vp", ["library", "name"]);

=head1 RELATIONS

=head2 fieldtofields

Type: has_many

Related object: L<AUApp::DB::Result::Fieldtofield>

=cut

__PACKAGE__->has_many(
  "fieldtofields",
  "AUApp::DB::Result::Fieldtofield",
  { "foreign.input_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 flow_inputs

Type: has_many

Related object: L<AUApp::DB::Result::FlowInput>

=cut

__PACKAGE__->has_many(
  "flow_inputs",
  "AUApp::DB::Result::FlowInput",
  { "foreign.input" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 flows

Type: has_many

Related object: L<AUApp::DB::Result::Flow>

=cut

__PACKAGE__->has_many(
  "flows",
  "AUApp::DB::Result::Flow",
  { "foreign.output" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 indexed_sequential

Type: might_have

Related object: L<AUApp::DB::Result::IndexedSequential>

=cut

__PACKAGE__->might_have(
  "indexed_sequential",
  "AUApp::DB::Result::IndexedSequential",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 library

Type: belongs_to

Related object: L<AUApp::DB::Result::Abstractlibrary>

=cut

__PACKAGE__->belongs_to(
  "library",
  "AUApp::DB::Result::Abstractlibrary",
  { id => "library" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 logical_physical_logicals

Type: has_many

Related object: L<AUApp::DB::Result::LogicalPhysical>

=cut

__PACKAGE__->has_many(
  "logical_physical_logicals",
  "AUApp::DB::Result::LogicalPhysical",
  { "foreign.logical" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 logical_physical_physicals

Type: has_many

Related object: L<AUApp::DB::Result::LogicalPhysical>

=cut

__PACKAGE__->has_many(
  "logical_physical_physicals",
  "AUApp::DB::Result::LogicalPhysical",
  { "foreign.physical" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 measure

Type: belongs_to

Related object: L<AUApp::DB::Result::Measure>

=cut

__PACKAGE__->belongs_to(
  "measure",
  "AUApp::DB::Result::Measure",
  { id => "measure" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 printer

Type: might_have

Related object: L<AUApp::DB::Result::Printer>

=cut

__PACKAGE__->might_have(
  "printer",
  "AUApp::DB::Result::Printer",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_inputs

Type: has_many

Related object: L<AUApp::DB::Result::ProgramInput>

=cut

__PACKAGE__->has_many(
  "program_inputs",
  "AUApp::DB::Result::ProgramInput",
  { "foreign.input" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_outputs

Type: has_many

Related object: L<AUApp::DB::Result::ProgramOutput>

=cut

__PACKAGE__->has_many(
  "program_outputs",
  "AUApp::DB::Result::ProgramOutput",
  { "foreign.output" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 record

Type: belongs_to

Related object: L<AUApp::DB::Result::Type>

=cut

__PACKAGE__->belongs_to(
  "record",
  "AUApp::DB::Result::Type",
  { id => "record" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 screen

Type: might_have

Related object: L<AUApp::DB::Result::Screen>

=cut

__PACKAGE__->might_have(
  "screen",
  "AUApp::DB::Result::Screen",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UJsPx89uveQw4pwBki5C8A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
