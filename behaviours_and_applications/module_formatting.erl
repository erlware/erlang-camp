%%%-------------------------------------------------------------------
%%% @author Martin Logan <martinjlogan@erlware.org>
%%% @copyright (C) 2012, Erlware
%%% @doc
%%%  A simple module for demonstrating how to setup a module
%%% @end
%%% Created : 22 Sep 2012 by Martin Logan <martinjlogan@Martins-MacBook-Air.local>
%%%-------------------------------------------------------------------
-module(module_formatting).

-export([start/0, init/1]).


%%% API Functions

%% @doc starts the server
-spec start() -> pid(). 
start() ->
    spawn(module_formatting, init, [self()]).

%%% Callback Functions

%% @doc initializes the server
-spec init(From) -> no_return() when
      From :: pid().
init(From) ->
    loop(From).

%%% Internal Functions

%% @doc the main loop of the server
-spec loop(From :: pid()) -> no_return().
loop(From) ->
    receive
	_ ->
	    loop(From)
    end.
