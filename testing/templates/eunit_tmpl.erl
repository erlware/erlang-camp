%%%===================================================================
%%% Test Functions
%%%===================================================================

-ifndef(NOTEST).
-include_lib("eunit/include/eunit.hrl").

my_test() ->
    ok.

my_generator_test_() ->
    {setup, fun setup_fun/0, fun cleanup_fun/1,
     [fun my_test_fun/1]}.

-endif.
