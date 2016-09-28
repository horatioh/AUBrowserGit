use utf8;
package AUApp::Auswertung::Result::AuExtensionVInput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionVInput

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

=head1 TABLE: C<au_extension.V_Inputs>

=cut

__PACKAGE__->table("au_extension.V_Inputs");

=head1 ACCESSORS

=head2 program

  data_type: 'bigint'
  is_nullable: 1

=head2 input

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "program",
  { data_type => "bigint", is_nullable => 1 },
  "input",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-28 16:45:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zm1M8cO3l5wp4Q7aOKKkHQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
