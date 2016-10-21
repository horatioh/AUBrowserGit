use utf8;
package AUApp::Auswertung::Result::AuExtensionOnlyInput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionOnlyInput

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

=head1 TABLE: C<au_extension.only_inputs>

=cut

__PACKAGE__->table("au_extension.only_inputs");

=head1 ACCESSORS

=head2 io_type

  data_type: 'varchar'
  is_nullable: 1
  size: 8

=head2 id

  data_type: 'bigint'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 uri

  data_type: 'varchar'
  is_nullable: 1
  size: 32767

=head2 version

  data_type: 'integer'
  is_nullable: 1

=head2 library

  data_type: 'bigint'
  is_nullable: 1

=head2 measure

  data_type: 'bigint'
  is_nullable: 1

=head2 record

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "io_type",
  { data_type => "varchar", is_nullable => 1, size => 8 },
  "id",
  { data_type => "bigint", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "uri",
  { data_type => "varchar", is_nullable => 1, size => 32767 },
  "version",
  { data_type => "integer", is_nullable => 1 },
  "library",
  { data_type => "bigint", is_nullable => 1 },
  "measure",
  { data_type => "bigint", is_nullable => 1 },
  "record",
  { data_type => "bigint", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-04 14:48:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Juk3B90HAUtTJt17MWKLoQ
__PACKAGE__->add_columns("record", { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 });
__PACKAGE__->belongs_to(
  "record" ,
  "AUApp::Auswertung::Result::AuExtensionVType",
  { 'foreign.id' => 'self.record' },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

__PACKAGE__->has_many(
  "fields",
  "AUApp::Auswertung::Result::AuExtensionVType",
  { "foreign.parent" => "self.record" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
