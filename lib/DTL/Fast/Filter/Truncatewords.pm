package DTL::Fast::Filter::Truncatewords;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Filter';

$DTL::Fast::FILTER_HANDLERS{'truncatewords'} = __PACKAGE__;

#@Override
sub parse_parameters
{
    my $self = shift;
    die "No max words number specified"
        if not scalar @{$self->{'parameter'}};
    $self->{'maxlen'} = $self->{'parameter'}->[0];
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
    my @value = split /(\s+)/s, $value;
    my $words = 0;
    my @newvalue = ();
    
    foreach my $value (@value)
    {
        if( $words == $maxlen )
        {
            last;
        }
        else
        {
            push @newvalue, $value;
            if( $value !~ /^\s+$/s )
            {
                $words++;
            }
        }
    }

    if( scalar @newvalue < scalar @value )
    {
        push @newvalue, '...';
    }
    
    return join '', @newvalue;
}


1;