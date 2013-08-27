%%% @doc essentials process exercises 

-module(ec_concurrent).
-export([bf_seq/1]).

%% @doc print 2 sequences simultaneously
-spec(bf_seq(list()) -> ok).
bf_seq(L) ->
	RL = lists:reverse(L),
	spawn(fun() -> print_seq(L) end),
	spawn(fun() -> print_seq(RL) end).

-spec(print_seq(list()) -> ok).
print_seq([H]) ->
	io:format("~p", [H]);
print_seq([H|T]) ->
	io:format("~p,", [H]),
	print_seq(T).

