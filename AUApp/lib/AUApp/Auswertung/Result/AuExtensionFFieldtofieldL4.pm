use utf8;
package AUApp::Auswertung::Result::AuExtensionFFieldtofieldL4;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionFFieldtofieldL4

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

=head1 TABLE: C<au_extension.f_fieldtofield_l4>

=cut

__PACKAGE__->table("au_extension.f_fieldtofield_l4");

=head1 ACCESSORS

=head2 l1_pgid

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_pgname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l1_flowid

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_inputid

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_sourceid

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_inputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l1_targetid

  data_type: 'bigint'
  is_nullable: 1

=head2 l1_outputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l2_pgid

  data_type: 'bigint'
  is_nullable: 1

=head2 l2_pgname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l2_flowid

  data_type: 'bigint'
  is_nullable: 1

=head2 l2_inputid

  data_type: 'bigint'
  is_nullable: 1

=head2 l2_sourceid

  data_type: 'bigint'
  is_nullable: 1

=head2 l2_inputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l2_targetid

  data_type: 'bigint'
  is_nullable: 1

=head2 l2_outputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l3_pgid

  data_type: 'bigint'
  is_nullable: 1

=head2 l3_pgname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l3_flowid

  data_type: 'bigint'
  is_nullable: 1

=head2 l3_inputid

  data_type: 'bigint'
  is_nullable: 1

=head2 l3_sourceid

  data_type: 'bigint'
  is_nullable: 1

=head2 l3_inputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l3_targetid

  data_type: 'bigint'
  is_nullable: 1

=head2 l3_outputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l4_pgid

  data_type: 'bigint'
  is_nullable: 1

=head2 l4_pgname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l4_flowid

  data_type: 'bigint'
  is_nullable: 1

=head2 l4_inputid

  data_type: 'bigint'
  is_nullable: 1

=head2 l4_sourceid

  data_type: 'bigint'
  is_nullable: 1

=head2 l4_inputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 l4_targetid

  data_type: 'bigint'
  is_nullable: 1

=head2 l4_outputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "l1_pgid",
  { data_type => "bigint", is_nullable => 1 },
  "l1_pgname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l1_flowid",
  { data_type => "bigint", is_nullable => 1 },
  "l1_inputid",
  { data_type => "bigint", is_nullable => 1 },
  "l1_sourceid",
  { data_type => "bigint", is_nullable => 1 },
  "l1_inputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l1_targetid",
  { data_type => "bigint", is_nullable => 1 },
  "l1_outputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l2_pgid",
  { data_type => "bigint", is_nullable => 1 },
  "l2_pgname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l2_flowid",
  { data_type => "bigint", is_nullable => 1 },
  "l2_inputid",
  { data_type => "bigint", is_nullable => 1 },
  "l2_sourceid",
  { data_type => "bigint", is_nullable => 1 },
  "l2_inputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l2_targetid",
  { data_type => "bigint", is_nullable => 1 },
  "l2_outputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l3_pgid",
  { data_type => "bigint", is_nullable => 1 },
  "l3_pgname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l3_flowid",
  { data_type => "bigint", is_nullable => 1 },
  "l3_inputid",
  { data_type => "bigint", is_nullable => 1 },
  "l3_sourceid",
  { data_type => "bigint", is_nullable => 1 },
  "l3_inputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l3_targetid",
  { data_type => "bigint", is_nullable => 1 },
  "l3_outputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l4_pgid",
  { data_type => "bigint", is_nullable => 1 },
  "l4_pgname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l4_flowid",
  { data_type => "bigint", is_nullable => 1 },
  "l4_inputid",
  { data_type => "bigint", is_nullable => 1 },
  "l4_sourceid",
  { data_type => "bigint", is_nullable => 1 },
  "l4_inputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "l4_targetid",
  { data_type => "bigint", is_nullable => 1 },
  "l4_outputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-28 16:45:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5tYC0SiRuYaqrMdibW2cvQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;