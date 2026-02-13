USING: challenge.lib command-line io kernel math
math.parser namespaces sequences splitting system ;
IN: challenge.run

: parse-numbers ( str -- seq )
    "," split [ string>number ] map ;

: main ( -- )
    command-line get dup length 2 < [
        "Usage: run.factor <numbers> <n>" print
        "Example: run.factor \"0 2 0 3 10\" 0" print
        1 exit
    ] [
        first2
        [ parse-numbers ] dip
        string>number
        movNums
        [ number>string ] map
        "," join
        print
    ] if ;

MAIN: main
