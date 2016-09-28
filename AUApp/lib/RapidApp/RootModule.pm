package RapidApp::RootModule;

use Moose;
use RapidApp::Util qw(:all);
extends 'RapidApp::Module';

require Module::Runtime;

=head1 NAME

RapidApp::RootModule;

=head1 DESCRIPTION

RootModule adds a small amount of custom processing needed for the usual "root module".

=head1 METHODS

=head2 BUILD

RootModule enables the auto_viewport capability of Controller by default.

=cut

our @GLOBAL_INIT_CODEREFS = ();

has 'app_title', is => 'rw', isa => 'Str', default => 'RapidApp Application';

has 'main_module_class', is => 'ro', isa => 'Maybe[Str]', lazy => 1, default => undef;
has 'main_module_params', is => 'ro', isa => 'HashRef', lazy => 1, default => sub {{}};

# default_module now 'main' by default:
around 'BUILDARGS' => sub {
	my ($orig, $class, @args)= @_;
	my $params= $class->$orig(@args);
	$params->{default_module} ||= 'main';
	$params->{module_name} ||= '';
	return $params;
};

around 'apply_init_modules' => sub {
  my ($orig,$self,@args) = @_;

  # Make the root module instance available via global. We have to do it here so it is
  # available to submodules that are still loading. This is a hack which is currently
  # only used/needed in RapidApp::TableSpec::Role::DBIC::get_or_create_rapidapp_module()
  local $RapidApp::ROOT_MODULE_INSTANCE = $self;

  $self->$orig(@args)
};

sub BUILD {
	my $self= shift;
  
	# Execute arbitrary code setup earlier in the init process that needs
	# to be called after the RapidApp Module tree has been loaded
	# See RapidApp::Util::rapidapp_add_global_init_coderef() for more info
	foreach my $coderef (@RapidApp::RootModule::GLOBAL_INIT_CODEREFS) {
		$coderef->($self);
	}
	
	$self->auto_viewport(1);
	
	## ---
	## NEW: optional auto initialization of the 'main' Module
	if($self->main_module_class) {
		Module::Runtime::require_module($self->main_module_class);
		$self->apply_init_modules(
			main => {
				class => $self->main_module_class,
				params => $self->main_module_params
			}
		);
	}
	##
	## ---
}

# Another ugly hack, added to make it easier to hook/wrap the top Controller.
# Does nothing but call the original by default, but can be changed.
# (Added for Plugin::AuthCore)
has '_around_Controller', is => 'rw', isa => 'CodeRef', default => sub { sub {
  my ($orig,$self,@args) = @_;
  return $self->$orig(@args);
}};

around 'Controller' => sub {
	my ($orig,$self,@a) = @_;
  my $c = $self->c;
  my $config = $c->config->{'Model::RapidApp'};
  
	$c->stash->{title} = $self->app_title;
  
  # Also ugly - double-nested around. We're doing it this way because we
  # want the '_around_Controller' to take priority over this code, which
  # still takes priority over the original.
  return $self->_around_Controller->(sub {

    # -----------
    # The special handling below only applies when we're deployed at the root
    # namespace of the app. If not, skip it and return now with default handling:
    return $self->$orig(@a) unless ($c->module_root_namespace eq '');
    # -----------

    my $args = $c->req->arguments;
    my ($opt) = @$args;
    
    # SPECIAL HANDLING FOR ROOT ('/') REQUEST:
    return $self->content unless ($opt || !$c->can('session') || (
      $c->can('session') && $c->session &&
      $c->session->{RapidApp_username}
    ));
    
    return $self->$orig(@a) unless (
      $opt && !$self->has_subarg($opt) &&
      $config->{root_template_prefix}
    );
    
    return $c->template_dispatcher->default($c,@$args);

    return $self->$orig(@a);
  },$self,@a);
};

# build a HTML viewport for the ExtJS content
# we override the config_url and the title
sub viewport {
	my $self= shift;
	my $ret= $self->SUPER::viewport;
	$self->c->stash->{config_url} = $self->base_url . '/' . $self->default_module;
	return $ret;
};


# NEW: handle root ('/') request with a template instead of error:
sub content {
  my $self = shift;
  my $c = $self->c;
  return $c->template_dispatcher->default($c);
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;