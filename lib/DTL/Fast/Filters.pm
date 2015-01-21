package DTL::Fast::Filters;
use strict; use utf8; use warnings FATAL => 'all'; 

# not in Django

# experimental
use DTL::Fast::Filter::Numberformat;

# built in filters
use DTL::Fast::Filter::Add;
use DTL::Fast::Filter::Addslashes;
use DTL::Fast::Filter::Capfirst;
use DTL::Fast::Filter::Center;
use DTL::Fast::Filter::Cut;
use DTL::Fast::Filter::Date;
use DTL::Fast::Filter::Default;
use DTL::Fast::Filter::DefaultIfNone;
use DTL::Fast::Filter::Dictsort;
use DTL::Fast::Filter::Dictsortreversed;
use DTL::Fast::Filter::Divisibleby;
use DTL::Fast::Filter::Escape;
use DTL::Fast::Filter::Escapejs;
use DTL::Fast::Filter::Filesizeformat;
use DTL::Fast::Filter::First;
use DTL::Fast::Filter::Floatformat;
use DTL::Fast::Filter::Getdigit;
use DTL::Fast::Filter::Iriencode;
use DTL::Fast::Filter::Join;
use DTL::Fast::Filter::Last;
use DTL::Fast::Filter::Length;
use DTL::Fast::Filter::Lengthis;
use DTL::Fast::Filter::Linebreaks;
use DTL::Fast::Filter::Linebreaksbr;
use DTL::Fast::Filter::Linenumbers;
use DTL::Fast::Filter::Ljust;
use DTL::Fast::Filter::Lower;
use DTL::Fast::Filter::MakeList;
use DTL::Fast::Filter::PhoneToNumeric;
use DTL::Fast::Filter::Pluralize;
use DTL::Fast::Filter::Random;
use DTL::Fast::Filter::Removetags;
use DTL::Fast::Filter::Reverse;
use DTL::Fast::Filter::Rjust;
use DTL::Fast::Filter::Safe;
use DTL::Fast::Filter::SafeSeq;
use DTL::Fast::Filter::Slice;
use DTL::Fast::Filter::Slugify;
use DTL::Fast::Filter::Strftime;
use DTL::Fast::Filter::Stringformat;
use DTL::Fast::Filter::Striptags;
use DTL::Fast::Filter::Time;
use DTL::Fast::Filter::Timesince;
use DTL::Fast::Filter::Timeuntil;
use DTL::Fast::Filter::Title;
use DTL::Fast::Filter::Truncatechars;
use DTL::Fast::Filter::Truncatecharshtml;
use DTL::Fast::Filter::Truncatewords;
use DTL::Fast::Filter::Truncatewordshtml;
use DTL::Fast::Filter::Unorderedlist;
use DTL::Fast::Filter::Upper;
use DTL::Fast::Filter::Urlencode;
use DTL::Fast::Filter::Urlize;
use DTL::Fast::Filter::Urlizetrunc;
use DTL::Fast::Filter::Wordcount;
use DTL::Fast::Filter::Wordwrap;
use DTL::Fast::Filter::Yesno;


1;
