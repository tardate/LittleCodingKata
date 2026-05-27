use Test::More tests => 3;
use Test::Exception;
use Exception::Class (
    'MyException' => { description => 'My custom exception' }
);

sub add_positives
{
    my ($l, $r) = @_;
    throw MyException("first argument ($l) was negative")  if $l < 0;
    throw MyException("second argument ($r) was negative") if $r < 0;
    return $l + $r;
}

throws_ok { add_positives( -7,  6 ) } 'MyException';
throws_ok { add_positives(  3, -9 ) } 'MyException';
throws_ok { add_positives( -5, -1 ) } 'MyException';
