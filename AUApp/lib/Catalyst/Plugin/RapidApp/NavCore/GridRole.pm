package Catalyst::Plugin::RapidApp::NavCore::GridRole;
use strict;
use warnings;
use Moose::Role;
with 'RapidApp::Module::StorCmp::Role::SavedSearch';

use RapidApp::Util qw(:all);

# This Role must be loaded in Grids for "Save Search" to be available in the
# options menu. Even if loaded, this Role will not enable itself unless the
# RapidApp::NavCore plugin has been loaded in the Catalyst app.

has '_navcore_enabled', is => 'ro', isa => 'Bool', lazy => 1, default => sub {
  my $self = shift;
  my $c = $self->c;
  return (
    $c->does('Catalyst::Plugin::RapidApp::NavCore') ||
    $c->registered_plugins('RapidApp::NavCore') #<-- this one doesn't seem to apply
  ) ? 1 : 0;
};

has 'plugin_config', is => 'ro', lazy => 1, default => sub {
  my $self = shift;
  my $c = $self->app;
  my $config = clone($c->config->{'Plugin::RapidApp::NavCore'} || {});
  
  # -- Default configs --
  
  # allow_manage: Whether or not to allow managing the Navtree (Organize Navtree)
  $config->{allow_manage} //= 1;
  
  # user_views: Whether or not to enable saved views/searches on a per-user basis
  # (also requires Auth to be enabled)
  $config->{user_views} //= 1;
  
  return $config;
};

around 'options_menu_items' => sub {
	my $orig = shift;
	my $self = shift;
  
  return $self->$orig(@_) unless ($self->_navcore_enabled);
	
	my $save_cnf = {};
	$save_cnf->{save_url} = $self->suburl('/save_search');
	$save_cnf->{search_id} = $self->c->req->params->{search_id} if (defined $self->c->req->params->{search_id});
	$save_cnf->{is_pub} = \1 if ($self->c->req->params->{public_search});
	
	# Turned off "Public Searches" now that we have the Manageable Public Navtree: (2012-02-18 by HV):
	#$save_cnf->{pub_allowed} = \1 if ($self->c->model('DB')->has_roles(qw/admin modify_public_searches/));
	
	my $params = { %{$self->c->req->params} };
	delete $params->{_dc} if (defined $params->{_dc});
	
	# Make sure search_id isn't saved (applies when saving searches of searches):
	delete $params->{search_id} if (exists $params->{search_id});
	
	$save_cnf->{target_url} = $self->base_url;
	$save_cnf->{target_params} = $self->json->encode($params);
	
	my $items = $self->$orig(@_) || [];
	
	push @$items, {
		text		=> 'Save Search',
		iconCls	=> 'ra-icon-save-as',
		handler	=> RapidApp::JSONFunc->new( raw => 1, func =>
			'function(cmp) { Ext.ux.RapidApp.NavCore.SaveSearchHandler(cmp,' . $self->json->encode($save_cnf) . '); }'
		)
	};
	
	
	if ($self->c->req->params->{search_id}) {
		push @$items, {
			text	=> 'Delete Search',
			iconCls	=> 'ra-icon-delete',
			handler	=> RapidApp::JSONFunc->new( raw => 1, func =>
				'function(cmp) { Ext.ux.RapidApp.NavCore.DeleteSearchHandler(cmp,"' . 
          $self->suburl('/delete_search') . '","' . $self->c->req->params->{search_id} . '"); }'
			)
		} unless (
			$self->c->req->params->{public_search} 
			and not $self->c->model('DB')->has_roles(qw/admin modify_public_searches/)
		);
	}
	
	return $items;
};




sub load_saved_search {
	my $self = shift;
	my $search_id = $self->c->req->params->{search_id} or return 0;
  
  
  return 0 unless ($self->_navcore_enabled);
  
	
	my $Search = $self->c->model('RapidApp::CoreSchema::SavedState')->find($search_id)
    or die usererr "Failed to load search ID '$search_id'";
	
	$self->apply_extconfig(
		tabTitle => $Search->get_column('title'),
		tabIconCls => $Search->get_column('iconcls'),
	);
	
	# Merge in params, even though the request is already underway:
	my $search_params = try{$self->json->decode($Search->get_column('params'))} || {};
	
	# TODO: this is now duplicated in the /view RequestMapper controller....
	my @not_allowed_params = qw(search_id quick_search quick_search_cols quick_search_mode);
	exists $search_params->{$_} and delete $search_params->{$_} for (@not_allowed_params);
	
	%{$self->c->req->params} = ( %{$self->c->req->params}, %$search_params );
	
	# Make sure search_id didn't get overridden: (issue with older saved searches)
	$self->c->req->params->{search_id} = $search_id;
	
	# Update the DataStore 'baseParams' - needed because this already happened by this point...
	my $baseParams = $self->DataStore->get_extconfig_param('baseParams') || {};
	my $new_base_params = try{$self->json->decode($search_params->{base_params})} || {};
	%$baseParams = ( %$baseParams, %$new_base_params );
	$self->DataStore->apply_extconfig( baseParams => $baseParams );
	
	
	my $search_data = $self->json->decode($Search->state_data) or die usererr "Error deserializing grid_state";
	
	$self->apply_to_all_columns( hidden => \1 );

	return $self->batch_apply_opts_existing($search_data);
}


sub save_search {
	my $self = shift;
	
	my $search_name = $self->c->req->params->{search_name}; 
	my $state_data = $self->c->req->params->{state_data};
	my $target_url = $self->c->req->params->{target_url};
	my $target_params = $self->c->req->params->{target_params};
	my $target_iconcls = $self->c->req->params->{target_iconcls};
	
	delete $self->c->req->params->{public_search} if (
		defined $self->c->req->params->{public_search} and
		$self->c->req->params->{public_search} eq 'false'
	);
	
	my $public = $self->c->req->params->{public_search};
	
	# This codepath should never happen because if they don't have permission
	# they shouldn't see the public checkbox in the first place:
	#die usererr "You are not allowed to save/modify public searches" if (
	#	$public and
	#	not $self->c->model('DB')->has_roles(qw/admin modify_public_searches/)
	#);
	
	$search_name = undef if (
		defined $search_name and 
		$search_name eq '' or
		$search_name eq 'false'
	);
	
	my $Rs = $self->c->model('RapidApp::CoreSchema::SavedState');
	
	# Update existing search:
	my $cur_id = $self->c->req->params->{cur_search_id};
	if ($cur_id and not $self->c->req->params->{create_search}) {
  
    # TODO: check permissions
    
    my $Search = $Rs->find($cur_id) 
      or die usererr "Cannot update existing search '" . $cur_id . "'\n";
  
		return $Search->update({ state_data => $state_data });
	}

	die usererr "Search name required" 
    unless (defined $search_name && $search_name ne '');
	
  # TODO: allow searches with the same name if different folder, etc
	$Rs->search_rs({ 'me.title' => $search_name })->count 
    and die usererr "Search '" . $search_name . "' already exists";
	
	my $create = {
    title => $search_name,
    url => $target_url,
    params => $target_params,
    iconcls => $target_iconcls,
    state_data => $state_data
	};
  
  my $User = try{$self->c->user->get_from_storage};
  if ($User && $self->plugin_config->{user_views}) {
    # If Auth is enabled, assign the new search to the logged in User:
    $create->{user_id} = $User->get_column('id');
  }
  else {
    # Otherwise, drop it directly into the root of the Public Navtree:
    $create->{node_id} = 0;
  }
	
	# Turn off public search stuff:
	#$create->{owner_id} = 1 if ($public);
	
	my $Row = $Rs->create($create);
	
	return {
		success	=> \1,
		msg		=> 'Created Search',
		loadCnf => $Row->loadContentCnf
	};
}



sub delete_search {
	my $self = shift;
	my $search_id = $self->c->req->params->{search_id} or die usererr "Missing search_id";
  
  # TODO: enfornce permissions
  
  
  my $Search = $self->c->model('RapidApp::CoreSchema::SavedState')->find($search_id)
    or die usererr "Failed to find search ID '$search_id'";
    
  return $Search->delete;
}




1;

