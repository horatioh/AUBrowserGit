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

  
sub input2output :Local {
    my ($self, $c, @args)= @_;
#$DB::single=1;
    $c->log->debug("Called AUApp::Controller::Auswertung action input2output");
    # Call run_sql_entry_level_input in model Auswertung to setup table entry_level
    $c->model('Auswertung')->run_sql_entry_level_input($c, @args);
    # Call run_sql_input_feld_2_feld in model Auswertung to setup table f_fieldtofield_result
    $c->model('Auswertung')->run_sql_input_feld_2_feld($c, @args);
    
    # Detach and show result table ffieldtofieldresult in schema auextension from model auswertung
    $c->detach('/approot',[ 'main' ,'db', 'auswertung_auextensionffieldtofieldresult' ]);


  }  
  
sub inputnoresult :Local {
    my ($self, $c, @args)= @_;
#$DB::single=1;
    $c->log->debug("Called AUApp::Controller::Auswertung action inputnoresult");
    # Call run_sql_entry_level_input in model Auswertung to setup table entry_level
    $c->model('Auswertung')->run_sql_entry_level_input($c, @args);
    # Call run_sql_inputohneoutput in model Auswertung to setup table f_input_ohne_output
    $c->model('Auswertung')->run_sql_inputohneoutput($c, @args);
    
    # Detach and show result table f_input_ohne_output in schema auextension from model auswertung
    $c->detach('/approot',[ 'main' ,'db', 'auswertung_auextensionfinputohneoutput' ]);


  }  

sub output2input :Local {
    my ($self, $c, @args)= @_;
#$DB::single=1;
    $c->log->debug("Called AUApp::Controller::Auswertung action output2input");
    # Call run_sql_entry_level_output in model Auswertung to setup table entry_level_output
    $c->model('Auswertung')->run_sql_entry_level_output($c, @args);
    # Call run_sql_output_feld_2_feld in model Auswertung to setup table f_fieldtofield_output_result
    $c->model('Auswertung')->run_sql_output_feld_2_feld($c, @args);
    
    # Detach and show result table ffieldtofieldresult in schema auextension from model auswertung
    $c->detach('/approot',[ 'main' ,'db', 'auswertung_auextensionffieldtofieldoutputresult' ]);


  }  
  
sub outputnoresult :Local {
    my ($self, $c, @args)= @_;
#$DB::single=1;
    $c->log->debug("Called AUApp::Controller::Auswertung action outputnoresult");
    # Call run_sql_entry_level_output in model Auswertung to setup table entry_level_output
    $c->model('Auswertung')->run_sql_entry_level_output($c, @args);
    # Call run_sql_outputohneinput in model Auswertung to setup table f_output_ohne_input
    $c->model('Auswertung')->run_sql_outputohneinput($c, @args);
    
    # Detach and show result table f_input_ohne_output in schema auextension from model auswertung
    $c->detach('/approot',[ 'main' ,'db', 'auswertung_auextensionfoutputohneintput' ]);


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
