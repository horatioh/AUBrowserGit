package AUApp::Module::ScriptTree;

use strict;
use warnings;

use Moose;
extends 'RapidApp::Module::NavTree';

use Data::Dumper;

has 'ScriptIconCl' , is=> 'ro', isa => 'Str', default => 'ra-icon-tree-edit';

has 'AnalyseScript', is=> 'ro', isa => 'ArrayRef[HashRef]', default => sub {
	my @script_items = (
	{
		id => 'analyse_scripts',
		text => 'Analyse Scripts',
		module => '',
		url => '',
		params => '',
		childs => [
		{
			id => 'setzeanalyseparameter',
			text => 'Setze Analyseparameter',
			module => '',
			url => '',
			params => '',
			childs => [
				{
					id => 'setinputdatei',
					text => 'Setze Analyse Inputdatei',
					module => '',
					url => 'main/db/auswertung_auextensionfinputdatei',
					params => '',
					childs => [],					
				},
#				{
#					id => 'setinputrecord',
#					text => 'Setze Analyse Inputrecord',
#					module => '',
#					url => 'main/db/auswertung_auextensionfinputrecord',
#					params => '',
#					childs => [],					
#				},
				{
					id => 'setinputfield',
					text => 'Setze Analyse Inputfeld',
					module => '',
					url => 'main/db/auswertung_auextensionfinputfeld',
					params => '',
					childs => [],					
				},
				{
					id => 'setoutputdatei',
					text => 'Setze Analyse Outputdatei',
					module => '',
					url => 'main/db/auswertung_auextensionfoutputdatei',
					params => '',
					childs => [],					
				},
#				{
#					id => 'setoutputrecord',
#					text => 'Setze Analyse Outputrecord',
#					module => '',
#					url => 'main/db/auswertung_auextensionfoutputrecord',
#					params => '',
#					childs => [],					
#				},
				{
					id => 'setoutputfield',
					text => 'Setze Analyse Outputfeld',
					module => '',
					url => 'main/db/auswertung_auextensionfoutputfeld',
					params => '',
					childs => [],					
				},				
			],
			
		},
		{
			id => 'allinputs',
			text => 'Nur Inputs',
			module => '',
			url => 'main/db/auswertung_auextensiononlyinput',
			params => '',
			childs => [],
		},
		{
			id => 'alloutputs',
			text => 'Nur Outputs',
			module => '',
			url => 'main/db/auswertung_auextensiononlyoutput',
			params => '',
			childs => [],
		},
		{
			id => 'field2outputs',
			text => 'Inputfelder zu Outputs',
			module => '',
			url => 'auswertung/input2output',
			params => '',
			childs => [],
		},
		{
			id => 'inputnoresult',
			text => 'Inputfelder ohne Outputs',
			module => '',
			url => 'auswertung/inputnoresult',
			params => '',
			childs => [],
		},
		
	#	{
	#		id => 'inputfieldtofield',
	#		text => 'Input Feld zu Feld',
	#		module => '',
	#		url => '',
	#		params => '',
	#	},
		{
			id => 'field2inputs',
			text => 'Outputfelder zu Inputs',
			module => '',
			url => 'auswertung/output2input',
			params => '',
			childs => [],
		},
		{
			id => 'outputnoresult',
			text => 'Outputfelder ohne Input',
			module => '',
			url => 'auswertung/outputnoresult',
			params => '',
			childs => [],
		},
		] ## End of children level 1
	}, ## Hashref Level 0
	);
	return \@script_items;

};


sub BUILD {
  my $self = shift;
 
#$DB::single=1; 

}

sub Controller {
  my ($self, $c, @args) = @_;

  $self->prepare_controller(@args);

  # dispatch the request to the appropriate handler

  $c->log->debug('ScriptTree Controler do dispatch --> ');
#$DB::single=1;

  $self->controller_dispatch(@args);
}

sub TreeConfig_orig{
	my $self = shift;
    my @items = ();

	push @items, $self->organize_navtree_node;

	return \@items;
};


sub TreeConfig{
	my $self = shift;
    my @items = ();

	foreach my $mi ( @{$self->AnalyseScript} )  {
		push @items, $self->organize_navtree_node_recursive($mi);
		$self->c->debug("Pushed Tree item:" . Dumper(@items));
	}
	return \@items;
};



# organize navtree_node_recursive gets a reference on a hash as parameter
sub organize_navtree_node_recursive {
	my $self = shift;
	my $root_href = shift; # reference on a hash
	
	## if no root_node passed as argument return empty list
	return {} unless $root_href; 
	$self->c->debug("Entered navtree_node_recursive with root_href:" . Dumper($root_href));
	
	my @children = ();
#	$DB::single=1;

	my $child_array_ref = $root_href->{childs};
	foreach my $si ( @{$child_array_ref} ) {
		$self->c->debug("Iterating element:" . Dumper($si));
#		$DB::single=1;

		my @child_item_array = ();
		if ( $si->{childs} )  {
			foreach my $ci ( @{ $si->{childs} } )  {	
				push @child_item_array, $self->organize_navtree_node_recursive($ci);
				$self->c->debug("Pushed Tree item:" . Dumper(@child_item_array));	
			}		
		}
		push @children, {
		        id      => $si->{id},
		        text    => $si->{text},
		        iconCls    => $self->ScriptIconCl,
		        module    => $si->{module},
		        url		=> $si->{url},
		        params    => $si->{params},
		        expand    => 0,
		        children  => \@child_item_array,
		        require_role => \0,
		      };
		};
 
	return {
		id			=> $root_href->{id},
		text		=> $root_href->{text},
		cls		=> 'pad-top-7px-bottom-4px',
		iconCls		=> $self->ScriptIconCl,
		module		=> $root_href->{module},
		url		=> $root_href->{url},
		params		=> $root_href->{params},
		expand		=> 0,
		children  => \@children,
	};
}


1;