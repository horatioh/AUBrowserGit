package AUApp::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller', 'RapidApp::ModuleDispatcher'; }

=head1 NAME

AUApp::Controller::Root - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut
__PACKAGE__->config( module_root_namespace => '' );

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched AUApp::Controller::Root in Root.');
}

sub approot :Path {
    my ($self, $c, @args)= @_;
    $c->log->debug("Called AUApp::Controller::Root action approot");
    $self->dispatch($c, @args);
  }
  
sub end : ActionClass('RenderView') {}



=encoding utf8

=head1 AUTHOR

U-GROUPINFRA\gitzelp,S-1-5-21-3641078771-3653456904-245653651-141386

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
