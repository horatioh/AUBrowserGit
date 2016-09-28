use utf8;
package AUApp::DB::Result::Fieldtofield;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::Fieldtofield

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<fieldtofield>

=cut

__PACKAGE__->table("fieldtofield");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

=head2 flow_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 input_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 source_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 target_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "flow_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "input_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "source_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "target_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-21 13:01:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:96xgo5V/lU6N0DRoxDi96g

__PACKAGE__->belongs_to(
  "source",
  "AUApp::DB::Result::Type",
  { id => "source_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

__PACKAGE__->belongs_to(
  "target",
  "AUApp::DB::Result::Type",
  { id => "target_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);
# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
