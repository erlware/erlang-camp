-module(implementation).
-export([start/0, store/2, lookup/1]).
-export([init/0, handle_msg/2]).

%%% API
start() ->
    container:start(?MODULE, ?MODULE).

store(Key, Value) ->
    container:send(?MODULE, {store, {Key, Value}}).

lookup(Key) ->
    container:send(?MODULE, {lookup, {Key, self()}}),
    receive
        Msg -> {ok, Msg}
    end.
    

%%% Internal Functions
init() ->
    {ok, []}.

handle_msg({lookup, {Key, From}}, State) ->
    From ! proplists:get_value(Key, State),
    {ok, State};
handle_msg({store, {Key, Value}}, State) ->
    io:format("storing ~p~n", [Key]),
    {ok, [{Key, Value}|State]}.
