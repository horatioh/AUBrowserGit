use utf8;
package AUApp::Auswertung::Result::AuExtensionFOutputOhneIntput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionFOutputOhneIntput

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

=head1 TABLE: C<au_extension.f_output_ohne_intput>

=cut

__PACKAGE__->table("au_extension.f_output_ohne_intput");

=head1 ACCESSORS

=head2 output_feld_id

  data_type: 'integer'
  is_nullable: 1

=head2 d_id

  data_type: 'integer'
  is_nullable: 1

=head2 d_name

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 d_type

  data_type: 'varchar'
  is_nullable: 1
  size: 10

=head2 d_recordid

  data_type: 'bigint'
  is_nullable: 1

=head2 d_parent

  data_type: 'bigint'
  is_nullable: 1

=head2 d_succession

  data_type: 'integer'
  is_nullable: 1

=head2 d_precision

  data_type: 'integer'
  is_nullable: 1

=head2 r_id

  data_type: 'bigint'
  is_nullable: 1

=head2 r_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 r_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 r_parent

  data_type: 'bigint'
  is_nullable: 1

=head2 r_succession

  data_type: 'integer'
  is_nullable: 1

=head2 r_precision

  data_type: 'integer'
  is_nullable: 1

=head2 f_id

  data_type: 'bigint'
  is_nullable: 1

=head2 f_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 f_type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 f_parent

  data_type: 'bigint'
  is_nullable: 1

=head2 f_succession

  data_type: 'integer'
  is_nullable: 1

=head2 f_precision

  data_type: 'integer'
  is_nullable: 1

=head2 io_uri

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 l1_flow_id

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_input_id

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_source_id

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_target_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "output_feld_id",
  { data_type => "integer", is_nullable => 1 },
  "d_id",
  { data_type => "integer", is_nullable => 1 },
  "d_name",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "d_type",
  { data_type => "varchar", is_nullable => 1, size => 10 },
  "d_recordid",
  { data_type => "bigint", is_nullable => 1 },
  "d_parent",
  { data_type => "bigint", is_nullable => 1 },
  "d_succession",
  { data_type => "integer", is_nullable => 1 },
  "d_precision",
  { data_type => "integer", is_nullable => 1 },
  "r_id",
  { data_type => "bigint", is_nullable => 1 },
  "r_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "r_type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "r_parent",
  { data_type => "bigint", is_nullable => 1 },
  "r_succession",
  { data_type => "integer", is_nullable => 1 },
  "r_precision",
  { data_type => "integer", is_nullable => 1 },
  "f_id",
  { data_type => "bigint", is_nullable => 1 },
  "f_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "f_type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "f_parent",
  { data_type => "bigint", is_nullable => 1 },
  "f_succession",
  { data_type => "integer", is_nullable => 1 },
  "f_precision",
  { data_type => "integer", is_nullable => 1 },
  "io_uri",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "l1_flow_id",
  { data_type => "bigint", is_nullable => 1 },
  "l1_input_id",
  { data_type => "bigint", is_nullable => 1 },
  "l1_source_id",
  { data_type => "bigint", is_nullable => 1 },
  "l1_target_id",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-04 14:48:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0uK7HUhqcfRzYIYP9oqMuA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
