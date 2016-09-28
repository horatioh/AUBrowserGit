#!/usr/bin/perl
use warnings;
use strict;
use FindBin qw/$Bin/;
use DBIx::Class::Schema::Loader qw/ make_schema_at /;

my @tables = ( abstractlibrary,
			   dynamiccall,
			   fieldtofield,
			   flow,
			   flow_input,
			   indexed_sequential,
			   input_output,
			   logical_physical,
			   measure,
			   printer,
			   program,
			   program_call,
			   program_error,
			   program_flow,
			   program_input,
			   program_output,
			   program_statement,
			   program_using,
			   screen,
			   step,
			   step_argument,
			   step_condition,
			   token,
			   type,
			   v_type	 );

my %options;
if (@ARGV)  {
  my $table = shift @ARGV;
  %options = ( 
  	constraint => $table,
  	components => [@ARGV]
  );
}

make_schema_at(
	'AUApp::DB',
	{
		%options,
		debug => 1,
		overwrite_modifications => 1,
		relationships => 1,
		use_namespaces => 1,
		dump_directory => "$Bin/../lib",
	},
	['dbi:Pg:dbname=au;host=localhost;port=5432','au','Vienna']
);

=head1 auapp_make_AU_schema.pl [table name] [components]

	Make the DBIC schema from the AU db; optionally, limit it to a
	particular table and add specific components to the table.
	
=cut