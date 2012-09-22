-module(sc_app).

-behaviour(application).

-export([start/2, stop/1]).

-define(WAIT_FOR_RESOURCES, 2500).

start(_StartType, _StartArgs) ->
    resource_discovery:add_local_resource_tuple({simple_cache, node()}),
    resource_discovery:add_target_resource_type(simple_cache),
    resource_discovery:sync_resources(),
    sc_store:init(),
    case sc_sup:start_link() of
        {ok, Pid} ->
            sc_event_logger:add_handler(),
            {ok, Pid};
        Other ->
            {error, Other}
    end.

stop(_State) ->
    ok.
