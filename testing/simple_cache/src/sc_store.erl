-module(sc_store).

-export([
         init/0,
         insert/3,
         delete/2,
         lookup/2
        ]).
init() ->
    dict:new()

insert(Store, Key, Pid) ->
    dict:store(Dict, {Key, Pid}).

lookup(Store, Key) ->
    dict:find(Dict, Key).

delete(Pid) ->
    dict:erase(?TABLE_ID, {'_', Pid}).
