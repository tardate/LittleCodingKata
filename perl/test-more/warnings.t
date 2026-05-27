use Test::More tests => 4;
use Test::Warn;

sub add_positives
{
    my ( $l, $r ) = @_;
    warn "first argument ($l) was negative"  if $l < 0;
    warn "second argument ($r) was negative" if $r < 0;
    return $l + $r;
}

warning_like { is( add_positives( 8, -3 ), 5 ) } qr/negative/;

warnings_like { is( add_positives( -8, -3 ), -11 ) }
    [ qr/first.*negative/, qr/second.*negative/ ];

