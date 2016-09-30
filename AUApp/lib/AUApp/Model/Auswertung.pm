package AUApp::Model::Auswertung;


use strict;
use base 'Catalyst::Model::DBIC::Schema';

use DBI;
use File::Slurp;
use SQL::SplitStatement;

use Moose;
#use MooseX::Types::Moose qw/Str/;
#use MooseX::Types::LoadableClass qw/LoadableClass/;

	
has 'fieldtofield_script' => (is => 'rw', isa => 'Str');



__PACKAGE__->config(
    schema_class => 'AUApp::Auswertung',
    fieldtofield_script => 'root/sql/au_fields/fieldtofieldzuordnung.sql',
    connect_info => {
        dsn => 'dbi:Pg:dbname=au;host=localhost;port=5432',
        user => 'au',
        password => 'Vienna',
        schema => 'au_extension',
    },
    RapidDbic => {

    # use only the relationship column of a foreign-key and hide the
    # redundant literal column when the names are different:
    hide_fk_columns => 1,

    # The grid_class is used to automatically setup a module for each source in the
    # navtree with the grid_params for each source supplied as its options.
    grid_class  => 'AUApp::Module::GridBase',
    grid_params => {
      # The special '*defaults' key applies to all sources at once
      '*defaults' => {
        include_colspec => ['*'],    #<-- default already ['*']
        ## uncomment these lines to turn on editing in all grids
        #updatable_colspec   => ['*'],
        #creatable_colspec   => ['*'],
        #destroyable_relspec => ['*'],
        extra_extconfig => {
          store_button_cnf => {
            save => { showtext => 1},
            undo => { showtext => 1 },
            
          }
        }
      },
      'AuExtensionFieldParameter' => {
        updatable_colspec   => ['*'],
        creatable_colspec   => ['*'],
        destroyable_relspec => ['*'],
      	
      },
    },
  },
);

=head1 NAME

AUApp::Model::Auswertung - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<AUApp>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<AUApp::Auswertung>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

U-GROUPINFRA\gitzelp,S-1-5-21-3641078771-3653456904-245653651-141386

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub run_sql_script  {
	my ($self, $c, $script)= @_;
$DB::single=1;
	my $connect_dsn = $self->connect_info->{dsn};
	my $connect_user = $self->connect_info->{user};
	my $connect_password = $self->connect_info->{password};
	my $schema = $self->connect_info->{schema};
	
	
	$c->log->debug("Run_sql_script called");
	my $sql_blob = read_file( $script ) or $c->log->error( "Error reading SQL script: $script" );
	my @sql_list = SQL::SplitStatement->new()->split($sql_blob);
	
	my $dbh = DBI->connect( $connect_dsn, $connect_user , $connect_password, {
        PrintError => 1,
        AutoCommit => 0
  });
    $c->log->debug("SQL Execute:  set search_path to $schema");
  	$dbh->do("set search_path to $schema") or $c->log->error( $dbh->errstr );
	foreach my $sql (@sql_list) {
	  $c->log->debug("SQL Execute:  $sql");
	  $dbh->do($sql) or $c->log->error( $dbh->errstr );
	}
}

sub run_sql_auswertung {
	my ($self, $c, $script)= @_;
	my $script = $self->fieldtofield_script;
	my $pwd = `pwd`;
	
	$c->log->debug("Run_sql_auswertung called with Pwd: $pwd script: $script");
	$self->run_sql_script($c, $script);
}
no Moose;
__PACKAGE__->meta->make_immutable;	
1;
