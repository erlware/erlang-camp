-module (weapon_component).
-behaviour(gen_event).

-export([init/1,
         handle_event/2,
         handle_call/2,
         handle_info/2,
         code_change/3,
         terminate/2]).

init(WeaponsList) ->
    {ok, WeaponsList}.

handle_event({add_weapon, ??}, ??) ->

handle_event({remove_weapon, ??}, ??) ->

handle_event({list_weapons}, ??) ->

%% Add "WMD" to list of weapons when x is 489, and y is 937
%%handle_event({change, {{x, y}, {NewX, NewY}}}, ??) ->

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
