use utf8;
package AUApp::DB::Result::ProgramUsing;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::ProgramUsing

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

=head1 TABLE: C<program_using>

=cut

__PACKAGE__->table("program_using");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 program

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 statement_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 used

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "program",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "statement_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "used",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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

=head2 statement

Type: belongs_to

Related object: L<AUApp::DB::Result::Token>

=cut

__PACKAGE__->belongs_to(
  "statement",
  "AUApp::DB::Result::Token",
  { id => "statement_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 used

Type: belongs_to

Related object: L<AUApp::DB::Result::Program>

=cut

__PACKAGE__->belongs_to(
  "used",
  "AUApp::DB::Result::Program",
  { id => "used" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:RTmkB69clvu1lqnF/ReqJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
