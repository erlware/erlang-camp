%%% @doc Bunch of different exception scenerios 

-module(ec_exception).
-export([try_of_fail1/0]).

try_of_fail1() ->
	try_of_fail1(fun() -> ok end).

try_of_fail1(Fun) ->
	try Fun() of
		ok -> 
			try_of_fail1(fun() -> lists:reverse(not_a_list) end)
	catch
		error:function_clause ->
			io:format("~nException: error~nError: function_clause~n"),
			try_of_fail1(fun() -> throw(my_throw) end);
		throw:my_throw ->
			io:format("~nException: throw~nError: my_throw~n"),
			try_of_fail1(fun() -> erlang:error(my_erlang_error) end);
		error:my_erlang_error ->
			io:format("~nException: error~nError: my_erlang_error~n"),
			try_of_fail1(fun() -> exit(my_exit) end);
		exit:my_exit ->
			io:format("~nException: exit~nError: my_exit~n")
	end.
