use utf8;
package AUApp::DB::Result::AllCall;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::AllCall

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

=head1 TABLE: C<all_calls>

=cut

__PACKAGE__->table("all_calls");

=head1 ACCESSORS

=head2 program

  data_type: 'bigint'
  is_nullable: 1

=head2 called

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "program",
  { data_type => "bigint", is_nullable => 1 },
  "called",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Z9Vg2wmoR1NZn6XyvrHMkg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
