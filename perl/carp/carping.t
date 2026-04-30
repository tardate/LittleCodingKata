use Test::More 'no_plan';
use Test::Warn;
use Carp;

sub add_positives
{
  my ( $l, $r ) = @_;
  carp "first argument ($l) was negative"  if $l < 0;
  carp "second argument ($r) was negative" if $r < 0;
  croak "second argument was zero" if $r == 0;
  return $l + $r;
}

warning_like { is( add_positives( 8, -3 ), 5 ) } qr/negative/;

warnings_like { is( add_positives( -8, -3 ), -11 ) }
  [ qr/first.*negative/, qr/second.*negative/ ];

eval { add_positives( 8, 0 ) };
ok( $@, 'second argument was zero' ) ;
