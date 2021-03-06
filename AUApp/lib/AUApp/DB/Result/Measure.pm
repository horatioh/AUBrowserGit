use utf8;
package AUApp::DB::Result::Measure;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Measure

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

=head1 TABLE: C<measure>

=cut

__PACKAGE__->table("measure");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 function_points

  data_type: 'integer'
  is_nullable: 0

=head2 loc

  data_type: 'integer'
  is_nullable: 0

=head2 nonempty_loc

  data_type: 'integer'
  is_nullable: 0

=head2 version

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "function_points",
  { data_type => "integer", is_nullable => 0 },
  "loc",
  { data_type => "integer", is_nullable => 0 },
  "nonempty_loc",
  { data_type => "integer", is_nullable => 0 },
  "version",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 input_outputs

Type: has_many

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->has_many(
  "input_outputs",
  "AUApp::DB::Result::InputOutput",
  { "foreign.measure" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 programs

Type: has_many

Related object: L<AUApp::DB::Result::Program>

=cut

__PACKAGE__->has_many(
  "programs",
  "AUApp::DB::Result::Program",
  { "foreign.measure" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:URsjzPWxe6/T4sTu0FVK9Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
