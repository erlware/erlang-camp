%%% @doc a bit of higher order functional goodness

-module(ec_lists).
-export([remove_odd/1, twomult/1, yourmap/2]).

%% @doc remove odd elements from a list of integers
-spec remove_odd(list()) -> list().
remove_odd(List) ->
	remove_odd(List, []).

-spec remove_odd(list(), list()) -> list().
remove_odd([], Acc) ->
	Acc;
remove_odd([H|T], Acc) when H rem 2 == 0 ->
	remove_odd(T, [H|Acc]);
remove_odd([_H|T], Acc) ->
	remove_odd(T, Acc).

%% @doc multiply each integer in the given list by 2
-spec twomult(list()) -> list().
twomult([H|T]) ->
	[H * 2|twomult(T)];
twomult([]) -> 
	[].

%% @doc multiply each element by 2
-spec yourmap(fun(), list()) -> list().
yourmap(Fun, [H|T]) ->
	[Fun(H)|yourmap(Fun, T)];
yourmap(_Fun, []) -> 
	[].

