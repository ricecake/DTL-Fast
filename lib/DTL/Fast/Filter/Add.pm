package DTL::Fast::Filter::Add;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Filter';

$DTL::Fast::FILTER_HANDLERS{'add'} = __PACKAGE__;

use Scalar::Util qw(looks_like_number);

#@Override
sub parse_parameters
{
    my $self = shift;
    
    die "No single arguments passed to the add ".__PACKAGE__
        if(
            ref $self->{'parameter'} ne 'ARRAY'
            or not scalar @{$self->{'parameter'}}
        );
        
    $self->{'parameters'} = [@{$self->{'parameter'}}];

    return $self;
}

#@Override
sub filter
{
    my $self = shift;
    my $filter_manager = shift;
    my $value = shift;
    my $context = shift;
    
    my $result = $value;
    my $value_type = ref $value;
    
    if( $value_type eq 'HASH' )
    {
        $result = {%$value};
    }
    elsif( $value_type eq 'ARRAY' )
    {
        $result = [@$value];
    }
    elsif( $value_type ) # @todo here we can implement ->add interface
    {
        die "Don't know how to add anything to $value_type";
    }
    
    foreach my $parameter (@{$self->{'parameters'}})
    {
        my $argument = $parameter->render($context);
        
        my $result_type = ref $result;
        my $argument_type = ref $argument;
        
        if( $result_type eq 'HASH' )
        {
            if( $argument_type eq 'ARRAY' )
            {
                %$result = (%$result, @$argument);
            }
            elsif( $argument_type eq 'HASH' )
            {
                %$result = (%$result, %$argument);
            }
            else
            {
                die "It's not possible to add a single value to a hash";
            }
        }
        elsif( $result_type eq 'ARRAY' )
        {
            if( $argument_type eq 'ARRAY' )
            {
                push @$result, @$argument;
            }
            elsif( $argument_type eq 'HASH' )
            {
                push @$result, (%$argument);
            }
            else
            {
                push @$result, $argument;
            }
        }
        elsif( looks_like_number($result) and looks_like_number($argument) )
        {
            $result += $argument;
        }
        else
        {
            $result .= $argument;
        }        
    }
    
    return $result;
}

1;