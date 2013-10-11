-module (xy_component).
-behaviour(gen_event).

-export([init/1,
         handle_event/2,
         handle_call/2,
         handle_info/2,
         code_change/3,
         terminate/2]).

init({X, Y, Width, Height, Rotation}) ->
  {ok, {X, Y, Width, Height, Rotation}}.

handle_event({change, {x, NewX}}, {OldX, OldY, W, H, Rotation}) ->
    io:format("Entity moved from (~p, ~p) to (~p, ~p).~n", [OldX, OldY, NewX, OldY]),
    {ok, {NewX, OldY, W, H, Rotation}};

handle_event({change, {y, NewY}}, {OldX, OldY, W, H, Rotation}) ->
    io:format("Entity moved from (~p, ~p) to (~p, ~p).~n", [OldX, OldY, OldX, NewY]),
    {ok, {OldX, NewY, W, H, Rotation}};

%% Update coordinates for both x and y
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
