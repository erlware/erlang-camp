%%% @author Sammy Lambda
%%% @doc some mathematical functions.
%%% @copyright 2013 Erlware
-module(ec_math).
-export([op/3, op_w_guards/3]). 

%% @doc perform a mathematical operation.
-spec(op(atom(), number(), number()) -> number()).
op(add, A, B) -> 
    A + B;
op(sub, A, B) ->
    A - B.

%% @doc perform a mathematical operation but use guards.
-spec(op_w_guards(atom(), number(), number()) -> number()).
op_w_guards(add, A, B) -> 
    A + B;
op_w_guards(sub, A, B) when A < B ->
    error;
op_w_guards(sub, A, B) ->
	A - B.

