USING: tools.test io io.streams.null kernel namespaces sequences ;

USE: challenge.lib

IN: challenge.test-suite

: test-all ( -- )
    [ "challenge" test ] with-null-writer ! (2)
    test-failures get empty? ! (3)
    [ "All tests passed." print ] [ :test-failures ] if ; ! (4)

MAIN: test-all
