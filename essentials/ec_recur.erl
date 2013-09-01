%%% @author Billy Erlware
%%% @doc a function that sums a sequence.
%%% @copyright Erlware 2013
-module(ec_recur).
-export([sum_seq/1, sum_seq_tail/1, hr/1]). 

%% @doc sum a sequence of a number to 1.
-spec sum_seq(number()) -> number().
sum_seq(1) -> 
	1;
sum_seq(N) ->
	N + sum_seq(N - 1).

%% @doc sum a sequence of a number to 1.
-spec sum_seq_tail(number()) -> number().
sum_seq_tail(N) ->
    sum_seq(N, 0).

sum_seq(0, Acc) ->
	Acc;
sum_seq(N, Acc) -> 
	sum_seq(N - 1, N + Acc). 

%% Tail recursive
-spec hr(number()) -> number().
hr(N) ->
	hr(N, "").

-spec hr(number(), string()) -> number().
hr(0, Acc) ->
	Acc;
hr(N, Acc) ->
	hr(N - 1, Acc ++ "-").
