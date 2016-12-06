use utf8;
package AUApp::Auswertung::Result::AuExtensionFFieldtofieldInputResult;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionFFieldtofieldInputResult

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

=head1 TABLE: C<au_extension.f_fieldtofield_input_result>

=cut

__PACKAGE__->table("au_extension.f_fieldtofield_input_result");

=head1 ACCESSORS

=head2 level

  data_type: 'integer'
  is_nullable: 1

=head2 input_feld_id

  data_type: 'integer'
  is_nullable: 1

=head2 input_feld_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 program_id

  data_type: 'bigint'
  is_nullable: 1

=head2 program_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 program_uri

  data_type: 'varchar'
  is_nullable: 1
  size: 32767

=head2 flow_id

  data_type: 'bigint'
  is_nullable: 1

=head2 input_id

  data_type: 'bigint'
  is_nullable: 1

=head2 input_file_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 input_uri

  data_type: 'varchar'
  is_nullable: 1
  size: 32767

=head2 source_id

  data_type: 'bigint'
  is_nullable: 1

=head2 source_feld_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 output_id

  data_type: 'bigint'
  is_nullable: 1

=head2 output_file_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 output_uri

  data_type: 'varchar'
  is_nullable: 1
  size: 32767

=head2 target_id

  data_type: 'bigint'
  is_nullable: 1

=head2 target_feld_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "level",
  { data_type => "integer", is_nullable => 1 },
  "input_feld_id",
  { data_type => "integer", is_nullable => 1 },
  "input_feld_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "program_id",
  { data_type => "bigint", is_nullable => 1 },
  "program_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "program_uri",
  { data_type => "varchar", is_nullable => 1, size => 32767 },
  "flow_id",
  { data_type => "bigint", is_nullable => 1 },
  "input_id",
  { data_type => "bigint", is_nullable => 1 },
  "input_file_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "input_uri",
  { data_type => "varchar", is_nullable => 1, size => 32767 },
  "source_id",
  { data_type => "bigint", is_nullable => 1 },
  "source_feld_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "output_id",
  { data_type => "bigint", is_nullable => 1 },
  "output_file_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "output_uri",
  { data_type => "varchar", is_nullable => 1, size => 32767 },
  "target_id",
  { data_type => "bigint", is_nullable => 1 },
  "target_feld_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-12-05 13:41:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rE6ZxaBwGe1mw7+UUqVu8A

#__PACKAGE__->belongs_to(
#  "program",
#  "AUApp::Auswertung::Result::AuExtensionVProgram",
#  { id => "program_id" },
# { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
#);


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
