package AUApp::Controller::Assets::AuSrcDir;
use parent 'Catalyst::Controller::AutoAssets';

#__PACKAGE__->config(
#   			type => 'Directory',
#   			include => '/home/gitzelp/aon/src_all',
#   			allow_static_requests => 1,	
#);


sub index :Chained :PathPrefix {
  my ($self, $c, @args) = @_;
#$DB::single=1;
  $c->log->debug("AUApp::Controller::Assets::AuSrcDir: index");
    
  # New: set 'abort' just like Static::Simple to suppress log messages:
  if ( $self->no_logs && $c->log->can('abort') ) {
    $c->log->abort( 1 );
  }
  
  $self->request($c,@args);
  $c->detach;
} 
 
1;