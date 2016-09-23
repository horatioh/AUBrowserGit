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

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

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

=head1 RELATIONS

=head2 flow

Type: belongs_to

Related object: L<AUApp::DB::Result::Flow>

=cut

__PACKAGE__->belongs_to(
  "flow",
  "AUApp::DB::Result::Flow",
  { id => "flow_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 input

Type: belongs_to

Related object: L<AUApp::DB::Result::InputOutput>

=cut

__PACKAGE__->belongs_to(
  "input",
  "AUApp::DB::Result::InputOutput",
  { id => "input_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 source

Type: belongs_to

Related object: L<AUApp::DB::Result::Type>

=cut

__PACKAGE__->belongs_to(
  "source",
  "AUApp::DB::Result::Type",
  { id => "source_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 target

Type: belongs_to

Related object: L<AUApp::DB::Result::Type>

=cut

__PACKAGE__->belongs_to(
  "target",
  "AUApp::DB::Result::Type",
  { id => "target_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VChaVljujqQjFsyigTiL0A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
