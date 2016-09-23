use utf8;
package AUApp::DB::Result::Program;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Program

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

=head1 TABLE: C<program>

=cut

__PACKAGE__->table("program");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 alias_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 dialect

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 source_language

  data_type: 'integer'
  is_nullable: 1

=head2 modifier

  data_type: 'integer'
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

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "alias_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "dialect",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "source_language",
  { data_type => "integer", is_nullable => 1 },
  "modifier",
  { data_type => "integer", is_nullable => 0 },
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
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<ukshkho6dobona6vlk6wlwxr8r6>

=over 4

=item * L</library>

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("ukshkho6dobona6vlk6wlwxr8r6", ["library", "name"]);

=head1 RELATIONS

=head2 dynamiccalls

Type: has_many

Related object: L<AUApp::DB::Result::Dynamiccall>

=cut

__PACKAGE__->has_many(
  "dynamiccalls",
  "AUApp::DB::Result::Dynamiccall",
  { "foreign.program" => "self.id" },
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

=head2 program_call_programs

Type: has_many

Related object: L<AUApp::DB::Result::ProgramCall>

=cut

__PACKAGE__->has_many(
  "program_call_programs",
  "AUApp::DB::Result::ProgramCall",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_calls_called

Type: has_many

Related object: L<AUApp::DB::Result::ProgramCall>

=cut

__PACKAGE__->has_many(
  "program_calls_called",
  "AUApp::DB::Result::ProgramCall",
  { "foreign.called" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_errors

Type: has_many

Related object: L<AUApp::DB::Result::ProgramError>

=cut

__PACKAGE__->has_many(
  "program_errors",
  "AUApp::DB::Result::ProgramError",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_flows

Type: has_many

Related object: L<AUApp::DB::Result::ProgramFlow>

=cut

__PACKAGE__->has_many(
  "program_flows",
  "AUApp::DB::Result::ProgramFlow",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_inputs

Type: has_many

Related object: L<AUApp::DB::Result::ProgramInput>

=cut

__PACKAGE__->has_many(
  "program_inputs",
  "AUApp::DB::Result::ProgramInput",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_outputs

Type: has_many

Related object: L<AUApp::DB::Result::ProgramOutput>

=cut

__PACKAGE__->has_many(
  "program_outputs",
  "AUApp::DB::Result::ProgramOutput",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 program_using_programs

Type: has_many

Related object: L<AUApp::DB::Result::ProgramUsing>

=cut

__PACKAGE__->has_many(
  "program_using_programs",
  "AUApp::DB::Result::ProgramUsing",
  { "foreign.program" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 programs_using_used

Type: has_many

Related object: L<AUApp::DB::Result::ProgramUsing>

=cut

__PACKAGE__->has_many(
  "programs_using_used",
  "AUApp::DB::Result::ProgramUsing",
  { "foreign.used" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6SHdDQ2SbwRIgk0fwODjcA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
