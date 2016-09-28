use utf8;
package AUApp::DB::Result::InputOutput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::InputOutput

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<input_output>

=cut

__PACKAGE__->table("input_output");

=head1 ACCESSORS

=head2 io_type

  data_type: 'varchar'
  is_nullable: 0
  size: 8

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 uri

  data_type: 'varchar'
  is_nullable: 1
  size: 32767

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 library

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 measure

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=head2 record

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "io_type",
  { data_type => "varchar", is_nullable => 0, size => 8 },
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "uri",
  { data_type => "varchar", is_nullable => 1, size => 32767 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "library",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "measure",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "record",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uk420h355gjp2ma90ceo3sjp2vp>

=over 4

=item * L</library>

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("uk420h355gjp2ma90ceo3sjp2vp", ["library", "name"]);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-21 13:37:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3kP4v8PqnibVVnW28HgbLA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
