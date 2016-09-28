use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AUApp';
use AUApp::Controller::AUApp::Root;

ok( request('/auapp/root')->is_success, 'Request should succeed' );
done_testing();
