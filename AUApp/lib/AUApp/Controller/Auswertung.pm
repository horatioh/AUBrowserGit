package AUApp::Controller::Auswertung;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AUApp::Controller::Auswertung - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut
# __PACKAGE__->config( module_root_namespace => '' );

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched AUApp::Controller::Auswertung in Action index.');
}

  
sub field_auswertung :Path {
    my ($self, $c, @args)= @_;
$DB::single=1;
    $c->log->debug("Called AUApp::Controller::Root action field_auswertung");
    # Call run_sql_auswertung in model Auswertung
    $c->model('Auswertung')->run_sql_auswertung($c, @args);
    # Detach and show result table ffieldtofieldl4 in schema auextension from model auswertung
#    $c->detach('/approot',[ 'main/db/auswertung_auextensionffieldtofieldl4' ]);
    $c->detach('/approot',[ 'main' ,'db', 'auswertung_auextensionffieldtofieldl2' ]);


  }  
  
# sub end : ActionClass('RenderView') {}



=encoding utf8

=head1 AUTHOR

U-GROUPINFRA\gitzelp,S-1-5-21-3641078771-3653456904-245653651-141386

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
