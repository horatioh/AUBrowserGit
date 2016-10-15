use utf8;
package AUApp::Auswertung::Result::AuExtensionLAll;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionLAll

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

=head1 TABLE: C<au_extension.l_all>

=cut

__PACKAGE__->table("au_extension.l_all");

=head1 ACCESSORS

=head2 level

  data_type: 'integer'
  is_nullable: 1

=head2 output_feld_id

  data_type: 'integer'
  is_nullable: 1

=head2 flow_id

  data_type: 'bigint'
  is_nullable: 1

=head2 input_id

  data_type: 'bigint'
  is_nullable: 1

=head2 source_id

  data_type: 'bigint'
  is_nullable: 1

=head2 target_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "level",
  { data_type => "integer", is_nullable => 1 },
  "output_feld_id",
  { data_type => "integer", is_nullable => 1 },
  "flow_id",
  { data_type => "bigint", is_nullable => 1 },
  "input_id",
  { data_type => "bigint", is_nullable => 1 },
  "source_id",
  { data_type => "bigint", is_nullable => 1 },
  "target_id",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-04 14:48:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Oyx73SNFZHvGC9teY+SzBQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
