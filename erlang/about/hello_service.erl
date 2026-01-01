-module(hello_service).
-export([loop/0, hello/2]).
loop() ->
    receive
        {From, Msg} ->
            From ! ("Hi, " ++ Msg ++ "!"),
            loop()
end.

hello(To, Word) ->
    To ! {self(), Word},
    receive
        Hello -> Hello
    end.
