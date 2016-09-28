package RapidApp::RapidApp;

use Moose;
use namespace::autoclean;
extends 'Catalyst::Model';

# This makes $c->_app available, just like in Controllers:
with 'Catalyst::Component::ApplicationAttribute';

use RapidApp::Util qw(:all);
use Time::HiRes qw(gettimeofday);
use File::Spec;
use Module::Runtime qw( use_module );

# the package name of the catalyst application, i.e. "GreenSheet" or "HOPS"
has 'catalystAppClass', is => 'ro', isa => 'Str', lazy => 1,
  default => sub { (shift)->_app };

# the class name of the root module
has 'rootModuleClass' => ( is => 'rw', isa => 'Str', lazy_build => 1 );
sub _build_rootModuleClass {
	return (shift)->defaultRootModuleClass;
}

# the default root module class name
sub defaultRootModuleClass {
	return (shift)->catalystAppClass . '::Modules::Root';
}

# the config hash for the modules
has 'rootModuleConfig'  => ( is => 'rw', isa => 'HashRef' );

# whether to preload the modules at catalyst setup time
has 'preloadModules'    => ( is => 'rw', isa => 'Bool', default => 1 );

# the root model instance
has 'rootModule'        => ( is => 'rw', lazy_build => 1 );

has 'postprocessing_tasks' => ( is => 'rw', isa => 'ArrayRef', default => sub {[]} );

sub add_postprocessing_task {
	my $self= shift;
	push @{$self->postprocessing_tasks}, @_;
}

sub BUILD {
	my $self = shift;
  $RapidApp::CATALYST_CLASS = $self->_app;
}

sub _setup_finalize {
	my $self= shift;
	$self->performModulePreload() if ($self->preloadModules && !$ENV{NO_PRELOAD_MODULES});
}

sub _build_rootModule {
	my $self= shift;
	
  return;
  
	# if we're doing this at runtime, just load the module.
	if (RapidApp->active_request_context) {
		return $self->_load_root_module;
	}
	# else, we're preloading, and we want diagnostics
	else {
		$self->performModulePreload;
		return $self->rootModule;
	}
}

sub _load_root_module {
	my $self= shift;
	
	#my $log= sEnv->log;
	#sEnv->catalystClass->debug
	#	and $log->debug("Running require on root module ".$self->rootModuleClass);
	#$log->_flush if $log->can('_flush');
	Catalyst::Utils::ensure_class_loaded($self->rootModuleClass);
	
	my $mParams= $self->rootModuleConfig || {};
  $mParams->{app} = $self->_app;
	$mParams->{module_name}= '';
	$mParams->{module_path}= '/';
	$mParams->{parent_module_ref}= undef;
  
  my $cfg = $self->_app->config->{'RapidApp'} || {};
  $mParams->{auto_init_modules} = $cfg->{load_modules} if ($cfg->{load_modules});

  $self->rootModule($self->rootModuleClass->timed_new($mParams));
  
}

sub performModulePreload {
	my $self= shift;
	
	# Access the root module, causing it to get built
	# We set RapidAppModuleLoadTimeTracker to instruct the modules to record their load times.
	#if ($self->catalystAppClass->debug) {
	#	my $loadTimes= {};
	#	sEnv->applyForSub(
	#		{ RapidAppModuleLoadTimeTracker => $loadTimes },
	#		sub { $self->rootModule($self->_load_root_module) }
	#	);
	#	scalar(keys %$loadTimes)
	#		and $self->displayLoadTimes($loadTimes);
	#}
	#else {
		$self->rootModule($self->_load_root_module);
	#}
}

#sub displayLoadTimes {
#	my ($self, $loadTimes)= @_;
#	
#	my $bar= '--------------------------------------------------------------------------------------';
#	my $summary= "Loaded RapidApp Modules:\n";
#	my @colWid= ( 25, 50, 7 );
#	$summary.= sprintf(".%.*s+%.*s+%.*s.\n",     $colWid[0],      $bar,  $colWid[1],    $bar,  $colWid[2],   $bar);
#	$summary.= sprintf("|%*s|%*s|%*s|\n",       -$colWid[0], ' Module', -$colWid[1], ' Path', -$colWid[2], ' Time');
#	$summary.= sprintf("+%.*s+%.*s+%.*s+\n",     $colWid[0],      $bar,  $colWid[1],    $bar,  $colWid[2],   $bar);
#	my @prevPath= ();
#	for my $key (sort keys %$loadTimes) {
#		my ($path, $module, $time)= ($key, $loadTimes->{$key}->{module}, $loadTimes->{$key}->{loadTime});
#		$path=~ s|[^/]*?/| /|g;
#		$path=~ s|^ /|/|;
#		$module =~ s/^(.*::)//; # trim the leading portion of the package name
#		$module = substr($module, -$colWid[0]);  # cut of the front of the string if necesary
#		$path= substr($path, -$colWid[1]);
#		$summary.= sprintf("| %*s| %*s| %*.3f |\n", -($colWid[0]-1), $module, -($colWid[1]-1), $path, $colWid[2]-2, $time);
#	}
#	$summary.= sprintf("'%.*s+%.*s+%.*s'\n",     $colWid[0],      $bar,  $colWid[1],    $bar,  $colWid[2],   $bar);
#	$summary.= "\n";
#	
#	sEnv->log->debug($summary);
#}

sub largestCommonPrefix {
	my ($a, $b)= @_;
	my $i= 0;
}

sub module {
	my ($self, @path)= @_;
	if (scalar(@path) == 1) { # if path is a string, break it into its components
		@path= split('/', $path[0]);
	}
	@path= grep /.+/, @path;  # ignore empty strings
	
	my $m= $self->rootModule;
	for my $part (@path) {
		$m= $m->Module($part) or die "No such module: ".join('/',@path);
	}
	return $m;
}

has 'dirtyModules' => ( is => 'rw', isa => 'HashRef', default => sub {{}} );

sub markDirtyModule {
	my ($self, $module)= @_;
	$self->dirtyModules->{$module}= $module;
}


# The need for this cleanup process is a design flaw in the internals of
# RapidApp 'Modules' that will be factored away soon...
sub cleanupAfterRequest {
	my ($self, $c)= @_;
	return unless scalar(keys %{$self->dirtyModules} );
	
	my ($sec0, $msec0)= $c->debug && gettimeofday;
	
	$self->cleanDirtyModules($c);
	
	if ($c->debug) {
		my ($sec1, $msec1)= gettimeofday;
		my $elapsed= ($sec1-$sec0)+($msec1-$msec0)*.000001;
		
		$c->log->info(sprintf("Module init (ONREQUEST) took %0.3f seconds", $c->stash->{onrequest_time_elapsed}));
		$c->log->info(sprintf("Cleanup took %0.3f seconds", $elapsed));
	}
	
	# Now that the request is done, we can run post-processing tasks.
	# These might also get modules dirty, so we clean again after each one.
	if (scalar @{$self->postprocessing_tasks}) {
		my ($sec0, $msec0)= $c->debug && gettimeofday;
		my $reqid= $c->request_id;
		my $i= 1;
		while (my $sub= shift @{$self->postprocessing_tasks}) {
			local $c->{request_id}= $reqid.'.'.$i++;
      $sub->($c);
			$self->cleanDirtyModules($c);
		}
		
		if ($c->debug) {
			my ($sec1, $msec1)= gettimeofday;
			my $elapsed= ($sec1-$sec0)+($msec1-$msec0)*.000001;
			
			$c->log->info(sprintf("Post-processing tasks took %0.3f seconds", $elapsed));
		}
	}
}

sub cleanDirtyModules {
	my ($self, $c)= @_;
	my @modules= values %{$self->dirtyModules};
	for my $module (@modules) {
		$module->reset_per_req_attrs;
	}
	%{$self->dirtyModules}= ();
}

has '_requestCount' => ( is => 'rw', default => 0 );
sub requestCount {
	(shift)->_requestCount;
}
sub incRequestCount {
	my $self= shift;
	$self->_requestCount($self->_requestCount+1);
}

# RapidApp System Cache
has 'use_cache' => ( is => 'ro', lazy => 1, default => (
	defined $ENV{RAPIDAPP_NO_CACHE}
		? ( $ENV{RAPIDAPP_NO_CACHE} ? 0 : 1 )
		: 1
));

has 'cache_class' => ( is => 'ro', lazy => 1, default => 'CHI' );

has 'cache_opts' => ( is => 'ro', predicate => 'has_cache_opts' );

has 'cache_dir' => ( is => 'ro', lazy => 1, default => sub {
	my ( $self ) = @_;
	return File::Spec->catfile(File::Spec->tmpdir, 'RapidAppCache');
});

has 'cache' => ( is => 'ro', default => sub {
	my ( $self ) = @_;
	my %cache_opts;
	if ($self->has_cache_opts) {
		%cache_opts = %{$self->cache_opts};
	} else {
		%cache_opts = (
			driver => 'File',
			root_dir => $self->cache_dir,
			depth => 5,
			namespace => $self->cache_key,
		);
	}
	my $cache_class = $self->cache_class;
	Catalyst::Utils::ensure_class_loaded($cache_class);
	my $cache = $cache_class->new( %cache_opts );
	if ($ENV{RAPIDAPP_CLEAR_CACHE}) {
		$cache->clear();
	}
	return $cache;
});

# so far for the main namespace, will probably be changed, every
# systempart using the cache should make a clear key for the specific
# input and code that 
has 'cache_key' => ( is => 'ro', lazy => 1, default => sub {
	my ( $self ) = @_;
	my $class = ref $self;
	$class =~ s/::/_/g;
	return join('_',
		$class, map { use_module($_)->VERSION } (qw(
			RapidApp DBIx::Class SQL::Translator Catalyst::Runtime
		)),
	);
});

1;
