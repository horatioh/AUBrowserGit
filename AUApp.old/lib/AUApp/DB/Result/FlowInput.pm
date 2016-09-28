use utf8;
package AUApp::DB::Result::FlowInput;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::FlowInput

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 TABLE: C<flow_input>

=cut

__PACKAGE__->table("flow_input");

=head1 ACCESSORS

=head2 flow

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 input

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "flow",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "input",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
);

=head1 RELATIONS

=head2 flow

Type: belongs_to

Related object: L<AUApp::DB::Result::Flow>

=cut

__PACKAGE__->belongs_to(
  "flow",
  "AUApp::DB::Result::Flow",
  { id => "flow" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-21 13:37:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2yek6qNE6khUnCmtDxXA2Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
