use utf8;
package AUApp::Auswertung::Result::AuExtensionFFieldtofield;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionFFieldtofield

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

=head1 TABLE: C<au_extension.f_fieldtofield>

=cut

__PACKAGE__->table("au_extension.f_fieldtofield");

=head1 ACCESSORS

=head2 pgid

  data_type: 'bigint'
  is_nullable: 1

=head2 pgname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 flowid

  data_type: 'bigint'
  is_nullable: 1

=head2 inputid

  data_type: 'bigint'
  is_nullable: 1

=head2 sourceid

  data_type: 'bigint'
  is_nullable: 1

=head2 inputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 targetid

  data_type: 'bigint'
  is_nullable: 1

=head2 outputname

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "pgid",
  { data_type => "bigint", is_nullable => 1 },
  "pgname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "flowid",
  { data_type => "bigint", is_nullable => 1 },
  "inputid",
  { data_type => "bigint", is_nullable => 1 },
  "sourceid",
  { data_type => "bigint", is_nullable => 1 },
  "inputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "targetid",
  { data_type => "bigint", is_nullable => 1 },
  "outputname",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-28 16:45:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VoJBOiYzw1+OblBwIhWKOA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
