use utf8;
package AUApp::Auswertung::Result::AuExtensionFFieldtofieldResult;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::Auswertung::Result::AuExtensionFFieldtofieldResult

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

=head1 TABLE: C<au_extension.f_fieldtofield_result>

=cut

__PACKAGE__->table("au_extension.f_fieldtofield_result");

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

=head2 program_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

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

=head2 source_id

  data_type: 'bigint'
  is_nullable: 1

=head2 source_feld_name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

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
  "program_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "flow_id",
  { data_type => "bigint", is_nullable => 1 },
  "input_id",
  { data_type => "bigint", is_nullable => 1 },
  "input_file_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "source_id",
  { data_type => "bigint", is_nullable => 1 },
  "source_feld_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "target_id",
  { data_type => "bigint", is_nullable => 1 },
  "target_feld_name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-10-04 14:48:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ZLzAh1DVn3t+PvHClvpbQA
# my @primary_keys = ("level", "flow_id");
my @cols = qw/level flow_id source_id target_id/;
__PACKAGE__->set_primary_key( @cols);
__PACKAGE__->has_many(
  "target2source",
  "AUApp::Auswertung::Result::AuExtensionFFieldtofieldResult",
  { 
  	"foreign.source_id" => "self.target_id",
#  	"foreign.level" => "self.level + 1",
#  },
#  { cascade_copy => 0, cascade_delete => 0 },

#    sub {
#      my $args = shift;
#      return {
#        "$args->{foreign_alias}.source_id" => { -ident => "$args->{self_alias}.target_id" },
#        "$args->{foreign_alias}.year"   => { '>', "1979", '<', "1990" },
#      };
    },
);
__PACKAGE__->has_many(
  "source2target",
  "AUApp::Auswertung::Result::AuExtensionFFieldtofieldResult",
  { 
  	"foreign.target_id" => "self.source_id",
#  	"foreign.level" => "self.level + 1",
#  },
#  { cascade_copy => 0, cascade_delete => 0 },

#    sub {
#      my $args = shift;
#      return {
#        "$args->{foreign_alias}.source_id" => { -ident => "$args->{self_alias}.target_id" },
#        "$args->{foreign_alias}.year"   => { '>', "1979", '<', "1990" },
#      };
    },
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
