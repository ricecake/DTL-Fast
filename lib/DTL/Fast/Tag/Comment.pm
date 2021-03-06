package DTL::Fast::Tag::Comment;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Tag';  

$DTL::Fast::TAG_HANDLERS{'comment'} = __PACKAGE__;

use DTL::Fast::Text;

#@Override
sub get_close_tag{return 'endcomment';}

#@Override
sub parse_next_chunk
{
    my $self = shift;
    my $chunk = shift @{$self->{'raw_chunks'}};
    
    if( $chunk =~ /^\{\%\s*endcomment\s*\%\}$/six )
    {
        $self->{'raw_chunks'} = []; # this stops parsing
    }
    
    return;
}

#@Override
sub render
{
    return '';
}

1;