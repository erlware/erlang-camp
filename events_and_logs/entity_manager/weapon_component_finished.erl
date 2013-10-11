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

handle_event({add_weapon, Weapon}, WeaponsList) ->
    io:format("Adding weapon ~p to arsenal~n", [Weapon]),
    {ok, [Weapon | WeaponsList]};

handle_event({remove_weapon, Weapon}, WeaponsList) ->
    io:format("Removing weapon ~p from arsenal~n", [Weapon]),
    {ok, lists:delete(Weapon, WeaponsList)};

handle_event({list_weapons}, WeaponsList) ->
    io:format("Current weapons: ~p~n", [WeaponsList]),
    {ok, WeaponsList};

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
