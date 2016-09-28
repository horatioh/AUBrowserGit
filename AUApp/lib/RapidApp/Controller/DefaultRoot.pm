package RapidApp::Controller::DefaultRoot;

use strict;
use warnings;

use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller', 'RapidApp::ModuleDispatcher'; }

use RapidApp::Util qw(:all);

=head1 NAME

RapidApp::Controller::DefaultRoot

=head1 DESCRIPTION

This controller is injected into the user's application unless they define a different controller
that extends ModuleDispatcher.  This is merely the default, if they didn't specify one.

=head1 CONFIGURATION

This module (like any other RapidApp module) needs to have a list of its sub-modules.

You can specify this using the Catalyst config system:

  MyApp::Controller::RapidApp::Root:
    modules:
      main: MyApp::Modules::Main

along with any of the attributes for TopController.

=head1 EXTENDING

Rather than extending from this class (which would only save you a few lines), you can just
as easily write your own controller which inherits from TopController:

  package MyApp::Controller::Root;
  
  use Moose;
  use namespace::autoclean;
  BEGIN { extends 'Catalyst::Controller', 'RapidApp::ModuleDispatcher'; }
  
  __PACKAGE__->config( namespace => '' );
  
  sub approot :Path {
    my ($self, $c, @args)= @_;
    $self->dispatch($c, @args);
  }
  
  sub end : ActionClass('RenderView') {}
  
  no Moose;
  __PACKAGE__->meta->make_immutable;
  1;

The benefits you do gain from extending this default are the ability to plug in
other RapidApp features like Direct Links or Exception Logging.  However, these
features could also be easily plugged into a custom top controller.

=cut

before 'COMPONENT' => sub {
  my $class = shift;
  my $app_class = ref $_[0] || $_[0];

  my $module_root_namespace = $app_class->module_root_namespace;
  $class->config( namespace => $module_root_namespace || '' );
};

sub process { (shift)->approot(@_) }

# --- Update to GitHub PR #142 ---
# SWITCHED approot FROM :Chained BACK TO ORIGINAL :Path
#
# 'approot' is the special controller action which is the catch-all that hands
# off the dispatch into the Module controller hierarchy, which is a very non-standard
# setup in terms of the Catalyst dispatcher. The switch to :Chained in PR #142
# for approot results in it getting higher priority than locally defined :Path
# controllers - which we don't want - so for now we're switching just this action 
# back to :Path. The rest of the controller actions that were switched to :Chained 
# in PR #142 are working fine and will be kept as-is, since :Chained is still preferred.
# TODO: revisit this again to see if there is a better solution...
#
#sub approot :Chained :PathPrefix :Args {
sub approot :Path {
  my ($self, $c, @args) = @_;

  # Handle url string mode:
  if(scalar(@args) == 1 && $args[0] =~ /^\//) {
    my $url = $args[0];
    $url =~ s/^\///; #<-- strip the leading '/' (needed for split below)
    
    # Automatically strip the namespace prefix if present:
    my $ns = $self->config->{namespace};
    $url =~ s/^${ns}\/?// if ($ns);
    
    @args = split(/\//,$url);
  }
  
  $self->dispatch($c, @args);
}

sub end : ActionClass('RenderView') {}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
