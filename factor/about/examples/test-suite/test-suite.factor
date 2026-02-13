USING: tools.test io io.streams.null kernel namespaces sequences ;

USE: examples.greeter

IN: examples.test-suite

: test-all-examples ( -- )
    [ "examples" test ] with-null-writer ! (2)
    test-failures get empty? ! (3)
    [ "All tests passed." print ] [ :test-failures ] if ; ! (4)

MAIN: test-all-examples
