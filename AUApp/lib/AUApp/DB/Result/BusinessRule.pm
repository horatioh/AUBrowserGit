use utf8;
package AUApp::DB::Result::BusinessRule;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::BusinessRule

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

=head1 TABLE: C<business_rule>

=cut

__PACKAGE__->table("business_rule");

=head1 ACCESSORS

=head2 flow

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 domain

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 complexity

  data_type: 'integer'
  is_nullable: 1

=head2 priority

  data_type: 'integer'
  is_nullable: 1

=head2 relevant

  data_type: 'boolean'
  is_nullable: 1

=head2 required

  data_type: 'boolean'
  is_nullable: 1

=head2 comment

  data_type: 'varchar'
  is_nullable: 1
  size: 1024

=cut

__PACKAGE__->add_columns(
  "flow",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "domain",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "complexity",
  { data_type => "integer", is_nullable => 1 },
  "priority",
  { data_type => "integer", is_nullable => 1 },
  "relevant",
  { data_type => "boolean", is_nullable => 1 },
  "required",
  { data_type => "boolean", is_nullable => 1 },
  "comment",
  { data_type => "varchar", is_nullable => 1, size => 1024 },
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 16:08:46
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:umSQQJigFeBihr/rVX5yWg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
