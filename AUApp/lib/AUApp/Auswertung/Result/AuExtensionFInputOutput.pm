use utf8;
package AUApp::Auswertung::Result::AuExtensionFInputOutput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionFInputOutput

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

=head1 TABLE: C<au_extension.f_input_output>

=cut

__PACKAGE__->table("au_extension.f_input_output");

=head1 ACCESSORS

=head2 io_id

  data_type: 'integer'
  is_nullable: 1

=head2 io_name

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 io_iotype

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 io_recordid

  data_type: 'bigint'
  is_nullable: 1

=head2 io_uri

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=cut

__PACKAGE__->add_columns(
  "io_id",
  { data_type => "integer", is_nullable => 1 },
  "io_name",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "io_iotype",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "io_recordid",
  { data_type => "bigint", is_nullable => 1 },
  "io_uri",
  { data_type => "varchar", is_nullable => 1, size => 100 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-28 16:45:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:O3nbY2cfKQqcSNx3LKuomA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
