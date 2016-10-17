use utf8;
package AUApp::Auswertung::Result::AuExtensionVFieldtofield;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionVFieldtofield - View on table public.fieldtofield

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

=head1 TABLE: C<au_extension.V_fieldtofield>

=cut

__PACKAGE__->table("au_extension.V_fieldtofield");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
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
  "id",
  { data_type => "bigint", is_nullable => 1 },
  "flow_id",
  { data_type => "bigint", is_nullable => 1 },
  "input_id",
  { data_type => "bigint", is_nullable => 1 },
  "source_id",
  { data_type => "bigint", is_nullable => 1 },
  "target_id",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-17 14:45:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Iqjj3ZAFsYn0s6cVpNR6VA
__PACKAGE__->set_primary_key("id");


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
