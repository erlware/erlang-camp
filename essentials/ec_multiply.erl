%%% @author Sammey Lambda
%%% @doc contains add func
%%% @copyright 2013 Erlware

-module(ec_multiply).
-export([mult/3]).

%%  @doc multiplies three numbers together.
-spec(mult(number(), number(), number()) -> number()).
mult(A, B, C) -> 
	A * B * C.

