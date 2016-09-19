use utf8;
package AUApp::DB::Result::VType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");
__PACKAGE__->table("v_type");
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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GWgq+Nv6o+5gqXzLYKBCCA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
