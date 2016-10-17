use utf8;
package AUApp::Auswertung::Result::AuExtensionVType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionVType - View on table public.type

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

=head1 TABLE: C<au_extension.V_type>

=cut

__PACKAGE__->table("au_extension.V_type");

=head1 ACCESSORS

=head2 record_type

  data_type: 'varchar'
  is_nullable: 1
  size: 3

=head2 id

  data_type: 'bigint'
  is_nullable: 1

=head2 declared_level

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 occurs

  data_type: 'integer'
  is_nullable: 1

=head2 precision

  data_type: 'integer'
  is_nullable: 1

=head2 scale

  data_type: 'integer'
  is_nullable: 1

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 using_of_parameter

  data_type: 'integer'
  is_nullable: 1

=head2 version

  data_type: 'integer'
  is_nullable: 1

=head2 adabas_id

  data_type: 'varchar'
  is_nullable: 1
  size: 2

=head2 parent

  data_type: 'bigint'
  is_nullable: 1

=head2 physical

  data_type: 'bigint'
  is_nullable: 1

=head2 redefine

  data_type: 'bigint'
  is_nullable: 1

=head2 succession

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "record_type",
  { data_type => "varchar", is_nullable => 1, size => 3 },
  "id",
  { data_type => "bigint", is_nullable => 1 },
  "declared_level",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "occurs",
  { data_type => "integer", is_nullable => 1 },
  "precision",
  { data_type => "integer", is_nullable => 1 },
  "scale",
  { data_type => "integer", is_nullable => 1 },
  "type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "using_of_parameter",
  { data_type => "integer", is_nullable => 1 },
  "version",
  { data_type => "integer", is_nullable => 1 },
  "adabas_id",
  { data_type => "varchar", is_nullable => 1, size => 2 },
  "parent",
  { data_type => "bigint", is_nullable => 1 },
  "physical",
  { data_type => "bigint", is_nullable => 1 },
  "redefine",
  { data_type => "bigint", is_nullable => 1 },
  "succession",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-17 14:45:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vb7vWmx/4UlVyv5bCueF+A
__PACKAGE__->set_primary_key("id");


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
