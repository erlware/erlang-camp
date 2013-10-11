-module (health_component).
-behaviour(gen_event).

-export([init/1,
         handle_event/2,
         handle_call/2,
         handle_info/2,
         code_change/3,
         terminate/2]).

init(HP) ->
    {ok, HP}.

handle_event({hit, Damage}, HP) when Damage < HP ->
    NewHP = HP - Damage,
    io:format("Entity got hit with ~p damage and has ~p HP left.~n", [Damage, NewHP]),
    {ok, NewHP};

handle_event({hit, _Damage}, 0) ->
    io:format("Entity is already DEAD!~n"),
    {ok, 0};

handle_event({hit, Damage}, _HP) ->
    io:format("Entity took ~p damage and DIED :(~n", [Damage]),
    {ok, 0};

handle_event(_, State) ->
    {ok, State}.

handle_call(_, State) ->
    {ok, ok, State}.

handle_info(_, State) ->
    {ok, State}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

terminate(_Args, _State) ->
    ok.
