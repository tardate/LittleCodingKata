USING: kernel sequences ;
IN: challenge.lib

: movNums ( seq n -- seq' )
    [ = ] curry partition swap append ;
