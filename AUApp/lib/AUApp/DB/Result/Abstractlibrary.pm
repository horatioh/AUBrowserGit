use utf8;
package AUApp::DB::Result::Abstractlibrary;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Abstractlibrary

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

=head1 TABLE: C<abstractlibrary>

=cut

__PACKAGE__->table("abstractlibrary");

=head1 ACCESSORS

=head2 library_type

  data_type: 'varchar'
  is_nullable: 0
  size: 6

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
  size: 255

=head2 version

  data_type: 'integer'
  is_nullable: 0

=head2 sublibrary_type

  data_type: 'integer'
  is_nullable: 1

=head2 database_id

  data_type: 'integer'
  is_nullable: 1

=head2 prime_library

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "library_type",
  { data_type => "varchar", is_nullable => 0, size => 6 },
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "uri",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "sublibrary_type",
  { data_type => "integer", is_nullable => 1 },
  "database_id",
  { data_type => "integer", is_nullable => 1 },
  "prime_library",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<ukkjdpayt5m64lvvo3mnf8hsddh>

=over 4

=item * L</prime_library>

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("ukkjdpayt5m64lvvo3mnf8hsddh", ["prime_library", "name"]);

=head1 RELATIONS

=head2 abstractlibraries

Type: has_many

Related object: L<AUApp::DB::Result::Abstractlibrary>

=cut

__PACKAGE__->has_many(
  "abstractlibraries",
  "AUApp::DB::Result::Abstractlibrary",
  { "foreign.prime_library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 input_outputs

Type: has_many

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->has_many(
  "input_outputs",
  "AUApp::DB::Result::InputOutput",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 prime_library

Type: belongs_to

Related object: L<AUApp::DB::Result::Abstractlibrary>

=cut

__PACKAGE__->belongs_to(
  "prime_library",
  "AUApp::DB::Result::Abstractlibrary",
  { id => "prime_library" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 programs

Type: has_many

Related object: L<AUApp::DB::Result::Program>

=cut

__PACKAGE__->has_many(
  "programs",
  "AUApp::DB::Result::Program",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2HXUXWpRw9+4aU1rq1l8RA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
