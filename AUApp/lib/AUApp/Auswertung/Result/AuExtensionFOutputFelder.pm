use utf8;
package AUApp::Auswertung::Result::AuExtensionFOutputFelder;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionFOutputFelder

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

=head1 TABLE: C<au_extension.f_output_felder>

=cut

__PACKAGE__->table("au_extension.f_output_felder");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns("id", { data_type => "integer", is_nullable => 1 });


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-04 14:48:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YiJnbP9PYP39ql8QHLHhmg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
