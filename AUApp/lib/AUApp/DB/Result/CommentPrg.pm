use utf8;
package AUApp::DB::Result::CommentPrg;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AUApp::DB::Result::CommentPrg - Comments related to program

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

=head1 TABLE: C<comment_prg>

=cut

__PACKAGE__->table("comment_prg");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_nullable: 0

id - unique comment block

=head2 program

  data_type: 'bigint'
  is_nullable: 1

reference to program.id

=head2 line_nr_from

  data_type: 'integer'
  is_nullable: 1

start line for comment block

=head2 line_nr_to

  data_type: 'integer'
  is_nullable: 1

end line for comment block

=head2 is_io_description

  data_type: 'boolean'
  is_nullable: 1

true if this block is the business descriptor for the referenced input_output 

=head2 comment

  data_type: 'varchar'
  is_nullable: 1
  size: '36864,1'

Comment block - max. 100kB

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "program",
  { data_type => "bigint", is_nullable => 1 },
  "line_nr_from",
  { data_type => "integer", is_nullable => 1 },
  "line_nr_to",
  { data_type => "integer", is_nullable => 1 },
  "is_io_description",
  { data_type => "boolean", is_nullable => 1 },
  "comment",
  { data_type => "varchar", is_nullable => 1, size => "36864,1" },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-23 15:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tTyQNC3VheSkrxILE6GUJw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
