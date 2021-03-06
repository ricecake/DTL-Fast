package DTL::Fast::Context;
use strict; use utf8; use warnings FATAL => 'all';
no if $] >= 5.017011, warnings => 'experimental::smartmatch';
use attributes;

sub new
{
    my( $proto, $context ) = @_;
    $context //= {};

    die  "Context should be a HASH reference"
        if ref $context ne 'HASH';

    return bless {
        'ns' => [$context]
    }, $proto;
}

sub get
{
    my( $self, $variable_path ) = @_;

    if( ref $variable_path ne 'ARRAY' )    # suppose that raw variable invoked, period separated
    {
        $variable_path = [split /\.+/x, $variable_path];
    }
    else
    {
        $variable_path = [@$variable_path]; # cloning for re-use
    }

    my $variable_name = shift @$variable_path;

    # faster version
    my $namespace = $self->{'ns'}->[-1];
    my $variable = exists $namespace->{$variable_name} ?
        $namespace->{$variable_name}
        : undef;

    while( ref $variable eq 'CODE' )
    {
        $variable = 'lvalue' ~~ attributes::get($variable) ?
            $variable->()
            : $variable->($self);
    }

    $variable = $self->traverse($variable, $variable_path)
        if
            defined $variable
            and scalar @$variable_path;

    return $variable;
}

# tracing variable path
sub traverse
{
    my( $self, $variable, $path ) = @_;

    foreach my $step (@$path)
    {
        my $current_type = ref $variable;
        if( $current_type eq 'HASH' )
        {
            $variable = $variable->{$step};
        }
        elsif(
            $current_type eq 'ARRAY'
            and $step =~ /^\-?\d+$/x
        )
        {
            $variable = $variable->[$step];
        }
        elsif( UNIVERSAL::can($variable, $step) )
        {
            $variable = 'lvalue' ~~ attributes::get($variable->can($step)) ?
                $variable->$step()
                : $variable->$step($self);
        }
        elsif( $current_type )
        {
            $variable = $variable->{$step};
        }
        else
        {
            die sprintf("Don't know how to traverse %s (%s) with %s"
                , $variable // 'undef'
                , $current_type // 'undef'
                , $step // 'undef'
            );
        }
    }

    while( ref $variable eq 'CODE' )
    {
        $variable = 'lvalue' ~~ attributes::get($variable) ?
            $variable->()
            : $variable->($self);
    }

    return $variable;
}

sub set
{
    my( $self, @sets ) = @_;

    while( scalar @sets > 1 )
    {
        my $key = shift @sets;
        my $val = shift @sets;
        if( $key =~ /\./x )  # traversed set
        {
            my @key = split /\.+/x, $key;
            my $variable_name = pop @key;
            my $variable = $self->get([@key]);

            die  sprintf('Unable to set variable %s because parent %s is not defined.'
                , $key // 'undef'
                , join('.', @key) // 'undef'
            ) if not defined $variable;

            my $variable_type = ref $variable;
            if( $variable_type eq 'HASH' )
            {
                $variable->{$variable_name} = $val;
            }
            elsif(
                $variable_type eq 'ARRAY'
                and $variable_name =~ /^\-?\d+$/x
            )
            {
                $variable->[$variable_name] = $val;
            }
            else
            {
                die  sprintf("Don't know how to set variable %s for parent node of type %s"
                    , $variable_name // 'undef'
                    , $variable_type // 'undef'
                );
            }
        }
        else
        {
            $self->{'ns'}->[-1]->{$key} = $val;
        }
    }
    return $self;
}

sub push_scope
{
    my( $self ) = @_;
#    push @{$self->{'ns'}}, {}; # multi-level version, suppose it's slower on reading
    push @{$self->{'ns'}}, {%{$self->{'ns'}->[-1] // {}}};
    return $self;
}

sub pop_scope
{
    my( $self ) = @_;
    die  "It's a last context layer available."
        if scalar @{$self->{'ns'}} ==  1;
    pop @{$self->{'ns'}};
    return $self;
}

1;
