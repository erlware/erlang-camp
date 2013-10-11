-module(sc_store).

-export([
         init/0,
         insert/3,
         delete/2,
         lookup/2
        ]).
init() ->
    dict:new().

insert(Store, Key, Value) ->
    dict:store(Key, Value, Store).

lookup(Store, Key) ->
    dict:find(Key, Store).

delete(Store, Key) ->
    dict:erase(Key, Store).
