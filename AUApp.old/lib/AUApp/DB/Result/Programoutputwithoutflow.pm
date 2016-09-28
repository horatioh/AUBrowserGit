use utf8;
package AUApp::DB::Result::Programoutputwithoutflow;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Programoutputwithoutflow

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<programoutputwithoutflow>

=cut

__PACKAGE__->table("programoutputwithoutflow");

=head1 ACCESSORS

=head2 program

  data_type: 'bigint'
  is_nullable: 1

=head2 output

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "program",
  { data_type => "bigint", is_nullable => 1 },
  "output",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-21 13:37:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aj3Zl7iuouG9FCfa4Sv4qA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
