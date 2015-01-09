package DTL::Fast::Template::Filter::Truncatechars;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Template::Filter';
use Carp qw(confess);

$DTL::Fast::Template::FILTER_HANDLERS{'truncatechars'} = __PACKAGE__;

use DTL::Fast::Template::Variable;

#@Override
sub parse_parameters
{
    my $self = shift;
    die "No max string length specified"
        if not scalar @{$self->{'parameter'}};
    $self->{'maxlen'} = DTL::Fast::Template::Variable->new($self->{'parameter'}->[0]);
    return $self;
}

#@Override
sub filter
{
    my $self = shift;  # self
    shift;  # filter_manager
    my $value = shift;
    my $context = shift;
    
    my $maxlen = $self->{'maxlen'}->render($context);
    if( length $value > $maxlen )
    {
        $value = substr $value, 0, $maxlen;
        $value =~ s/\s*$/.../s;
    }
    
    return $value;
}


1;