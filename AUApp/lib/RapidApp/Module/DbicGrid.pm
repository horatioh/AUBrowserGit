package RapidApp::Module::DbicGrid;

use strict;
use warnings;

use Moose;
extends 'RapidApp::Module::Grid';
with 'RapidApp::Module::StorCmp::Role::DbicLnk';

use RapidApp::Util qw(:all);

has 'show_base_conditions_in_header', is => 'ro', isa => 'Bool', default => 1;

# This property defines whether or not the 'Cell Editing' toggle button should start
# in the 'Off' or 'On' position. This only applies when the grid is initialized with
# a top toolbar, so there is a place to render the button, and also when the plugin
# grid-toggle-edit-cells is loaded (which it is, by default)
has 'toggle_edit_cells_init_off', default => sub {
  my $self = shift;
  # By default, we will initialize with 'Cell Editing Off' as long as there
  # is both an open_record_url and the grid uses the add form. Unless both 
  # of these conditions are true, we initialize with 'Cell Editing On'
  return $self->use_add_form && $self->open_record_url ? 1 : 0;
}, is => 'ro', isa => 'Bool', lazy => 1;


# Initial state for the total count toggle - See GitHub Issue #168
has 'init_total_count_off', is => 'ro', isa => 'Bool', default => 0, traits => ['ExtProp'];

sub BUILD {
	my $self = shift;
	
	if ($self->updatable_colspec) {
		$self->apply_extconfig( 
			xtype => 'appgrid2ed',
			clicksToEdit => 1,
		);
    
    # allow toggling
    $self->add_plugin('grid-toggle-edit-cells');
	}
	
	$self->apply_extconfig(
    use_multifilters   => \1,
    gridsearch_remote  => \1,
    setup_bbar_store_buttons => \1,
    toggle_edit_cells_init_off => $self->toggle_edit_cells_init_off ? \1 : \0,
    
    # Sane default for the add button/tab:
    store_button_cnf => {
      add => {
        text    => 'Add ' . $self->ResultClass->TableSpec_get_conf('title'),
        iconCls => 'ra-icon-add'
      },
    }
  );
	
	$self->apply_default_tabtitle;
	
	# New AppGrid2 nav feature. Need to always fetch the column to use for grid nav (open)
	push @{$self->always_fetch_columns}, $self->open_record_rest_key
		if ($self->open_record_rest_key);
	
}

has '+open_record_rest_key', default => sub {
	my $self = shift;
	return try{$self->ResultClass->TableSpec_get_conf('rest_key_column')};
};

sub apply_default_tabtitle {
	my $self = shift;
	# ---- apply default tab title and icon:
	my $class = $self->ResultClass;
	
	my $title = try{$class->TableSpec_get_conf('title_multi')} || try{
		my $table = $class->table;
		$table = (split(/\./,$table,2))[1] || $table; #<-- get 'table' for both 'db.table' and 'table' format
		return $table;
	};
	
	my $iconCls = try{$class->TableSpec_get_conf('multiIconCls')};
	$self->apply_extconfig( tabTitle => $title ) if ($title);
	$self->apply_extconfig( tabIconCls => $iconCls ) if ($iconCls);
	# ----
}

# Show that a base condition is in effect in the panel header, unless
# the panel header is already set. This is to help users to remember
# that a given grid was followed from a multi-rel column, for instance
# TODO: better styling
around 'content' => sub {
  my $orig = shift;
  my $self = shift;
  
  my $ret = $self->$orig(@_);
  
  if($self->show_base_conditions_in_header) {
    my $bP = try{$ret->{store}->parm->{baseParams}} || {};
    if ($bP->{resultset_condition}) {
      my $cls = 'blue-text';
      $ret->{tabTitleCls} = $cls;
      $ret->{headerCfg} ||= {
        tag   => 'div',
        cls   => 'panel-borders ra-footer',
        style => 'padding:3px;',
        html  => join('',
          '<i><span class="',$cls,'">',
          '<b>Base Condition:</b></span> ',
          $bP->{resultset_condition},'</i>'
        )
      };
    }
    elsif($bP->{rs_path} && $bP->{rs_method}){
      my ($pth,$ourPth) = ($bP->{rs_path},$self->module_path);
      
      #http://stackoverflow.com/a/9114752
      "$pth\0$ourPth" =~ m/^([^\0]*)(?>[^\0]*)\0\1/s;
      $pth =~ s/^${1}//; #<-- make the path relative to us for nice display
      
      my $cls = 'blue-text';
      $ret->{tabTitleCls} = $cls;
      $ret->{headerCfg} ||= {
        tag => 'div',
        cls => 'panel-borders ra-footer',
        style => 'padding:3px;',
        html  => join('',
          '<i><span class="',$cls,'">',
          '<b>ResultSet:</b></span> [',
          $pth,']: ',$bP->{rs_method},'</i>'
        )
      };
    }
  }
    
  return $ret;
};





#### --------------------- ####


no Moose;
#__PACKAGE__->meta->make_immutable;
1;