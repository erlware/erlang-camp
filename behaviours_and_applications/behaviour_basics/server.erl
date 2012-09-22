-module(server).
-export([start/0, store/2]).

%%% API

start() ->
    spawn(fun() -> init() end).

store(Key, Value) ->
    server ! {store, {Key, Value}}.

%%% Internal Functions

init() ->
    register(server, self()),
    io:format("starting~n"),
    loop([]).

loop(State) ->
    receive
	{store, {Key, Value}} ->
	    io:format("storing ~p~n", [Key]),
	    loop([{Key, Value}|State])
    end.
	    
