# Local AUApp configuration file. See Catalyst::Plugin::ConfigLoader
{  
   'Plugin::AutoAssets' => {
    	assets => [
    	{
    		controller => 'AUApp::Controller::Assets::AuSrcDir',
    		type => 'SourceDirectory',
    		include => '/home/gitzelp/aon/src_all',
#    		work_dir => '/home/gitzelp/aon/tmp',
			no_logs => 0,
    		allow_static_requests => 1,
    		persist_state => 1,
    	} ]
    },
    'Module::UriDbicPropPage' => {
    	URIBasePath => '/auapp/controller/assets/ausrcdir/static/',
    	URIFilePath => 'file\:\/\/\/C\:\/cygwin64\/home\/gitzelp\/aon\/src_all\/'
    }
} 