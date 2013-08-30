%%% @doc a bit of higher order functional goodness

-module(ec_lists).
-export([yourmap/2]).

%% @doc multiply each element by 2
-spec yourmap(fun(), list()) -> list().
yourmap(Fun, [H|T]) ->
	[Fun(H)|yourmap(Fun, T)];
yourmap(_Fun, []) -> 
	[].

