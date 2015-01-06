package DTL::Fast::Template::Tag::With;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Template::Tag';  
use Carp qw(confess);

$DTL::Fast::Template::TAG_HANDLERS{'with'} = __PACKAGE__;

#@Override
sub get_close_tag{return 'endwith';}

#@Override
sub parse_parameters
{
    my $self = shift;

    $self->{'mappings'} = {};
    if( $self->{'parameter'} =~ /^\s*(.+?)\s+as\s+(.+)\s*$/s )  # legacy
    {
        $self->{'mappings'}->{$2} = DTL::Fast::Template::Expression->new($1);
    }
    else    # modern
    {
        my @parts = split /\s+/, $self->backup_strings($self->{'parameter'});
        foreach my $part (@parts)
        {
            if( $part =~ /^([^.]+)\=(.+)$/ )
            {
                $self->{'mappings'}->{$1} = $self->get_backup_or_variable($2);
            }
            else
            {
                die "You must pass a list with key=val options to the with tag: $self->{'parameter'}";
            }            
        }
    }
    
    return $self;
}

#@Override
sub render
{
    my $self = shift;
    my $context = shift;
    
    $context->push();
    $context->set(
        map{
            $_ => $self->{'mappings'}->{$_}->render($context)
        } keys(%{$self->{'mappings'}})
    );
   
    my $result = $self->SUPER::render($context);

    $context->pop();
        
    return $result;
}

1;