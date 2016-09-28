use strict;
use warnings;

use AUApp;

my $app = AUApp->apply_default_middlewares(AUApp->psgi_app);
$app;

