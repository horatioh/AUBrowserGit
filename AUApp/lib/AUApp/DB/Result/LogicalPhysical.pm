use utf8;
package AUApp::DB::Result::LogicalPhysical;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::LogicalPhysical

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

=head1 TABLE: C<logical_physical>

=cut

__PACKAGE__->table("logical_physical");

=head1 ACCESSORS

=head2 logical

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 physical

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "logical",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "physical",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 RELATIONS

=head2 logical

Type: belongs_to

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->belongs_to(
  "logical",
  "AUApp::DB::Result::InputOutput",
  { id => "logical" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 physical

Type: belongs_to

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->belongs_to(
  "physical",
  "AUApp::DB::Result::InputOutput",
  { id => "physical" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UdPgR+5YVlC2q3xAofVGBQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
