use utf8;
package AUApp::DB::Result::ProgramInput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::ProgramInput

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

=head1 TABLE: C<program_input>

=cut

__PACKAGE__->table("program_input");

=head1 ACCESSORS

=head2 program

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 input

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "program",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "input",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 RELATIONS

=head2 input

Type: belongs_to

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->belongs_to(
  "input",
  "AUApp::DB::Result::InputOutput",
  { id => "input" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 program

Type: belongs_to

Related object: L<AUApp::DB::Result::Program>

=cut

__PACKAGE__->belongs_to(
  "program",
  "AUApp::DB::Result::Program",
  { id => "program" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kI2TJDxsdo84JlVk6/xrrA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
