use utf8;
package AUApp::DB::Result::Abstractlibrary;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';
__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table("abstractlibrary");
__PACKAGE__->add_columns(
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "uri",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "library_type",
  { data_type => "varchar", is_nullable => 0, size => 6 },
  "prime_library",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 1 },
  "sublibrary_type",
  { data_type => "integer", is_nullable => 1 },
  "id",
  { data_type => "bigint", is_nullable => 0 },
  "version",
  { data_type => "integer", is_nullable => 0 },
  "database_id",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("ukkjdpayt5m64lvvo3mnf8hsddh", ["prime_library", "name"]);
__PACKAGE__->has_many(
  "abstractlibraries",
  "AUApp::DB::Result::Abstractlibrary",
  { "foreign.prime_library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->has_many(
  "input_outputs",
  "AUApp::DB::Result::InputOutput",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);
__PACKAGE__->belongs_to(
  "prime_library",
  "AUApp::DB::Result::Abstractlibrary",
  { id => "prime_library" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);
__PACKAGE__->has_many(
  "programs",
  "AUApp::DB::Result::Program",
  { "foreign.library" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-09-17 15:10:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7/kkL82DA9iIw8pWXG/Kjg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
