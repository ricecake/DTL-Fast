#!/usr/bin/perl
use strict; use warnings FATAL => 'all'; 
use Test::More;

use DTL::Fast qw(get_template);
use DTL::Fast::Context;
use Data::Dumper;

my( $template, $test_string, $context);

my $dirs = ['./t/tmpl', './t/tmpl2'];
$context = new DTL::Fast::Context({
    'include' => ['included2.txt']
    , 'with' => {
        'substitution' => 'context text'
    }
});

$template = DTL::Fast::Template->new('This is {% debug %} text');
$test_string = 'This is '.Dumper($context).' text';
is( $template->render($context), $test_string, 'Debugging example');


done_testing();
