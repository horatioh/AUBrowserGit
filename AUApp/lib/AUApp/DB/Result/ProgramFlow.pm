use utf8;
package AUApp::DB::Result::ProgramFlow;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::ProgramFlow

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

=head1 TABLE: C<program_flow>

=cut

__PACKAGE__->table("program_flow");

=head1 ACCESSORS

=head2 program

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 flow

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 succession

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "program",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "flow",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "succession",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</program>

=item * L</succession>

=back

=cut

__PACKAGE__->set_primary_key("program", "succession");

=head1 RELATIONS

=head2 flow

Type: belongs_to

Related object: L<AUApp::DB::Result::Flow>

=cut

__PACKAGE__->belongs_to(
  "flow",
  "AUApp::DB::Result::Flow",
  { id => "flow" },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZzOBNt9vTZdRhVYWiohEgg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
