package AUApp::Module::PGTestNavtree;

use strict;
use warnings;

use Moose;
extends 'RapidApp::Module::NavTree';

use RapidApp::Util ':all';

sub BUILD {
  my $self = shift;
$DB::single=1;
#  $self->setup_nav_listeners;
}

has 'TreeConfig', is => 'ro', isa => 'ArrayRef[HashRef]', lazy => 1, default => sub {
  my $self = shift;
  
  my @m_entries = qw/ "Alle Inputs" "Alle Outputs"/;
  my @items = ();
  my $item_id = 0;
  for my $entries (@m_entries) {
  
#    my $require_role = $self->require_role || try{$self->configs->{$model}{require_role}};
#    my $menu_req_role = $require_role || $self->menu_require_role;
    
    my @children = ();
    my @s_entries = qw/"Sub 1" "Sub 2" "Sub 3"/;
    my $subs_id = 0;
    for my $subs (sort @s_entries) {
      my $text = $subs;
      my $iconCls = 'ra-icon-application-view-detail';
      push @children, {
        id      => $subs_id,
        text    => $text,
        iconCls    => $iconCls ,
#        module    => $module_name,
        params    => {},
        expand    => 1,
        children  => [],
#        require_role => $menu_req_role
      };
      ++$subs_id;      
    } # end of for my $subs
        
#    $self->apply_init_modules( $module_name => {
#      class => 'RapidApp::Module::DbicSchemaGrid',
#      params => { 
#        Schema => $self->app->model($model)->schema,
#        tabTitle => $text,
#        tabIconCls => $iconcls,
#        exclude_sources => $exclude_sources,
#        header_template => $template,
#        require_role => $require_role
#      }
#    });
    my $iconcls = 'ra-icon-application-view-detail';
    push @items, {
      id    => $item_id,
      text  => $entries,
      iconCls  => $iconcls,
#      module    => $module_name,
      params  => {},
      expand  => \1,
      children  => \@children,
#      require_role => $menu_req_role
    };
    ++$item_id;
  }
  
  return \@items;
};



sub Controller {
  my ($self, $c, @args) = @_;
#$DB::single=1;
  $self->prepare_controller(@args);

  # dispatch the request to the appropriate handler

  $c->log->debug('PGTestNavtree--> ' . 
    GREEN.BOLD . ref($self) . CLEAR . '  ' . 
    GREEN . join('/',@args) . CLEAR
  ) if ($c->debug);

  $self->controller_dispatch(@args);
}

1;